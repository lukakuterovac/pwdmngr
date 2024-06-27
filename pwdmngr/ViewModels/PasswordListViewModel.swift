//
//  PasswordListViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation

class PasswordListViewModel: ObservableObject {
    @Published var viewState: PasswordListViewState
    
    init(passwordItems: [PasswordItem]) {
        let viewState = PasswordListViewState(passwordItems: passwordItems)
        self.viewState = viewState
    }
    
    func updateList(passwordItems: [PasswordItem]) {
        self.viewState.passwordItems = passwordItems
    }
}
