//
//  PasswordDetailsViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 06.06.2024..
//

import SwiftUI
import Foundation
import Combine

class PasswordDetailsViewModel: ObservableObject {
    @Published var viewState: PasswordDetailsViewState
    private let dataModel: PasswordDataModel
    private var cancellables = Set<AnyCancellable>()
    
    init(passwordItem: PasswordItem, dataModel: PasswordDataModel) {
        let viewState = PasswordDetailsViewState(passwordItem: passwordItem)
        self.dataModel = dataModel
        self.viewState = viewState
        
        viewState.$passwordItem
            .dropFirst()
            .sink { [weak self] updatedItem in
                self?.dataModel.updateItem(updatedItem)
            }
            .store(in: &cancellables)
    }
    
    func saveChanges(passwordItem: PasswordItem) {
        viewState.passwordItem = passwordItem
        dataModel.updateItem(viewState.passwordItem)
    }
    
    func deleteItem() {
        print("VM deleteItem")
        dataModel.deleteItem(self.viewState.passwordItem)
    }
}
