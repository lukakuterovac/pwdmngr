//
//  AuthViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import LocalAuthentication

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage = ""
    private var key: String?
    
    init () {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await getUser()
        }
    }
    
    func getKey() -> String? {
        if let key = self.key {
            return key
        } else {
            return nil
        }
    }
    
    func signIn(email: String, password: String) async throws {
        errorMessage = ""
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await getUser()
            
            KeychainHelper.shared.saveEmail(email)
            KeychainHelper.shared.savePassword(password)
            
            self.key = password
        } catch {
            print("Error while signing in. \(error.localizedDescription)")
            errorMessage = "Invalid email or password."
        }
    }
    
    func signUp(email: String, password: String, confirmPassword: String) async throws {
        errorMessage = ""
        
        do {
            let emailExists = try await emailExistsInDatabase(email)
            guard !emailExists else {
                throw AuthError.emailAlreadyInUse
            }
            
            guard password == confirmPassword else {
                throw AuthError.passwordsDoNotMatch
            }
            
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await getUser()
            KeychainHelper.shared.saveEmail(email)
            KeychainHelper.shared.savePassword(password)
            
            self.key = password
        } catch {
            print("Error while signing up. \(error.localizedDescription)")
            switch error {
            case AuthError.emailAlreadyInUse:
                errorMessage = "Email already exists."
            case AuthError.passwordsDoNotMatch:
                errorMessage = "Passwords do not match."
            default:
                errorMessage = "Try again."
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Error while signing out. \(error.localizedDescription)")
        }
    }
    
    func getUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        if self.currentUser != nil {
            self.key = KeychainHelper.shared.getPassword()
        }
    }
    
    private func emailExistsInDatabase(_ email: String) async throws -> Bool {
        let querySnapshot = try await Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments()
        return !querySnapshot.isEmpty
    }
    
    enum AuthError: Error {
        case emailAlreadyInUse
        case passwordsDoNotMatch
    }
    
    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID / Touch ID to access your account"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        if let error = authenticationError {
                            print("Authentication failed: \(error.localizedDescription)")
                        }
                        completion(false)
                    }
                }
            }
        } else {
            if let error = error {
                print("Biometric authentication not available: \(error.localizedDescription)")
            }
            completion(false)
        }
    }
    
    func signInWithBiometrics() {
        authenticateWithBiometrics { success in
            if success {
                Task {
                    do {
                        if let email = KeychainHelper.shared.getEmail(),
                           let password = KeychainHelper.shared.getPassword() {
                            try await self.signIn(email: email, password: password)
                        } else {
                            self.errorMessage = "No saved credentials found."
                        }
                    } catch {
                        print("Error while signing in with biometrics: \(error.localizedDescription)")
                        self.errorMessage = "Biometric sign-in failed."
                    }
                }
            } else {
                self.errorMessage = "Biometric authentication failed."
            }
        }
    }
}
