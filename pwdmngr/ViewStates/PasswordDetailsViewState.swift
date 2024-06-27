//
//  PasswordDetailsViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 26.06.2024..
//

import Foundation

class PasswordDetailsViewState: ObservableObject {
    @Published var passwordItem: PasswordItem
    
    init(passwordItem: PasswordItem) {
        self.passwordItem = passwordItem
    }
}
