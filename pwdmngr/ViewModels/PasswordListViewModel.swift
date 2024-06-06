//
//  PasswordListViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation

class PasswordListViewModel: ObservableObject {
    @Published var viewState: PasswordListViewState
    
    init(viewState: PasswordListViewState = PasswordListViewState()) {
        self.viewState = viewState
    }
}
