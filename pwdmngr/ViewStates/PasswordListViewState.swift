//
//  PasswordListViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 06.06.2024..
//

import Foundation
import SwiftUI

class PasswordListViewState: ObservableObject {
    @Published var passwordItems: [PasswordItem]
    @State var isLoading: Bool = false
    
    init(passwordItems: [PasswordItem]) {
        self.passwordItems = passwordItems
    }
}
