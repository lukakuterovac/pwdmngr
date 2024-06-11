//
//  PasswordDetailsViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 06.06.2024..
//

import Foundation

class PasswordDetailsViewModel: ObservableObject {
    @Published var passwordItem: PasswordItem

    init(passwordItem: PasswordItem) {
        self.passwordItem = passwordItem
    }
    
    func saveChanges() {
        // Logic to save changes (e.g., update database or user defaults)
    }
}
