//
//  CreatePasswordViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import Foundation
import SwiftUI

class CreatePasswordViewModel: ObservableObject {
    @Published var viewState: CreatePasswordViewState
    
    var dataModel: PasswordDataModel
    var authViewModel: AuthViewModel
    
    init(dataModel: PasswordDataModel, authViewModel: AuthViewModel) {
        let viewState = CreatePasswordViewState()
        self.viewState = viewState
        self.dataModel = dataModel
        self.authViewModel = authViewModel
    }
    
    @MainActor
    func createPassword(completion: @escaping (Bool) -> Void) {
        guard let user = authViewModel.currentUser else {
            print("Current user not available")
            completion(false)
            return
        }
        
        let newPasswordItem = PasswordItem(userId: user.id, name: viewState.name, username: viewState.username, password: viewState.password, url: viewState.url)
        
        dataModel.addItem(newPasswordItem) { error in
            if let error = error {
                print("Error while adding password: \(error.localizedDescription)")
                completion(false)
            } else {
                DispatchQueue.main.async {
                    self.viewState = CreatePasswordViewState()
                    completion(true)
                }
                print("Password added successfully!")
            }
        }
    }
}
