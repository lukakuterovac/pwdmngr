//
//  SignInViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    private var keychain = KeychainHelper.shared
    
    init() {}
    
    func validateForm() -> Bool {
        return validateEmail() && validatePassword()
    }
    
    private func validateEmail() -> Bool {
        if !email.isEmpty && email.contains("@") && email.contains(".") {
            return true
        }
        return false
    }
    
    private func validatePassword() -> Bool {
        if !password.isEmpty && password.count >= 6 {
            return true
        }
        return false
    }
    
    func credentialsAvailable() -> Bool {
        if let email = keychain.getEmail() {
            return true
        }
        return false
    }
}
