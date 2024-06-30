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
                guard let self = self else { return }
                self.updateItem(updatedItem)
            }
            .store(in: &cancellables)
    }
    
    func saveChanges(passwordItem: PasswordItem) {
        viewState.passwordItem = passwordItem
        updateItem(viewState.passwordItem)
    }
    
    func deleteItem() {
        deleteItem(viewState.passwordItem)
    }
    
    private func updateItem(_ item: PasswordItem) {
        dataModel.updateItem(item) { error in
            if let error = error {
                print("Error updating password item: \(error)")
            }
        }
    }
    
    private func deleteItem(_ item: PasswordItem) {
        dataModel.deleteItem(item) { error in
            if let error = error {
                print("Error deleting password item: \(error)")
            } else {
                // Successfully deleted, potentially dismiss view or update UI
            }
        }
    }
}
