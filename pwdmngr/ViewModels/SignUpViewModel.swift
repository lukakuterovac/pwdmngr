//
//  SignUpViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    init() {}
    
    func validateForm() -> Bool {
        return validateEmail() && validatePasswords()
    }
    
    private func validateEmail() -> Bool {
        if !email.isEmpty && email.contains("@") && email.contains(".") {
            return true
        }
        return false
    }
    
    private func validatePasswords() -> Bool {
        if !password.isEmpty && password.count >= 6 && !confirmPassword.isEmpty && confirmPassword.count >= 6 {
            return true
        }
        return false
    }
    
    private func validateConfirmPassword() -> Bool {
        return password == confirmPassword
    }
}
