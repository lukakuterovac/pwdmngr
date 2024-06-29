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

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage = ""
    
    init () {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await getUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        errorMessage = ""
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await getUser()
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
    }
    
    private func emailExistsInDatabase(_ email: String) async throws -> Bool {
        let querySnapshot = try await Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments()
        return !querySnapshot.isEmpty
    }
    
    enum AuthError: Error {
        case emailAlreadyInUse
        case passwordsDoNotMatch
    }
}
