//
//  PasswordDetailsViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 26.06.2024..
//

import Foundation

class PasswordDetailsViewState: ObservableObject {
    @Published var passwordItem: PasswordItem
    @Published var isOptionsExpanded: Bool
    @Published var isShowingFullPassword: Bool
    
    init(passwordItem: PasswordItem) {
        self.passwordItem = passwordItem
        self.isOptionsExpanded = false
        self.isShowingFullPassword = false
    }
}
