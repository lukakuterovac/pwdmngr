//
//  PasswordDataModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 26.06.2024..
//

import Foundation

class PasswordDataModel: ObservableObject {
    @Published var passwordItems: [PasswordItem] = []
    
    init() {
        self.passwordItems = PasswordItem.createMockPasswordItems()
    }
    
    func addItem(_ item: PasswordItem) {
        passwordItems.append(item)
    }
    
    func updateItem(_ item: PasswordItem) {
        if let index = passwordItems.firstIndex(where: { $0.id == item.id }) {
            passwordItems[index] = item
        }
    }
    
    func deleteItem(_ item: PasswordItem) {
        passwordItems.removeAll { $0.id == item.id }
    }
}
