//
//  CreatePasswordView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CreatePasswordViewModel
    @ObservedObject private var viewState: CreatePasswordViewState

    
    init(dataModel: PasswordDataModel, authViewModel: AuthViewModel) {
        let viewModel = CreatePasswordViewModel(dataModel: dataModel, authViewModel: authViewModel)
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $viewState.name)
                            .textInputAutocapitalization(.never)
                    }
                    Section(header: Text("Username/Email")) {
                        TextField("Username/Email", text: $viewState.username)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    Section(header: Text("Password")) {
                        SecureField("Password", text: $viewState.password)
                            .textInputAutocapitalization(.never)
                    }
                    Section(header: Text("URL")) {
                        TextField("URL", text: $viewState.url)
                            .keyboardType(.URL)
                            .textInputAutocapitalization(.never)
                    }
                }
                .formStyle(.automatic)
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Button("Back") {
                            dismiss()
                        }
                        .frame(width: 60)
                        .font(.customFont(font: .lato, style: .medium, size: 16))
                        
                        Spacer()
                        
                        Text("New password")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Spacer()
                        
                        Button("Create") {
                            viewModel.createPassword() { success in
                                if success {
                                    dismiss()
                                }
                            }
                        }
                        .font(.customFont(font: .lato, style: .medium, size: 16))
                        .frame(width: 60)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.secondarySystemBackground))
        }
    }
}

#Preview {
    CreatePasswordView(dataModel: PasswordDataModel(), authViewModel: AuthViewModel())
}
