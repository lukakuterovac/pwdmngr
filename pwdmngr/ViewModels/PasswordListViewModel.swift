//
//  PasswordListViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation
import SwiftUI

class PasswordListViewModel: ObservableObject {
    @Published var viewState: PasswordListViewState
    @EnvironmentObject var dataModel: PasswordDataModel
    
    init() {
        let passwordItems: [PasswordItem] = []
        let viewState = PasswordListViewState(passwordItems: passwordItems)
        self.viewState = viewState
    }
}
