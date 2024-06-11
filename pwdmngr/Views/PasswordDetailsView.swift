//
//  PasswordDetailsView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 06.06.2024..
//

import SwiftUI

struct PasswordDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PasswordDetailsViewModel
    @State private var isEditing: Bool = false
    
    init(passwordItem: PasswordItem) {
        _viewModel = StateObject(wrappedValue: PasswordDetailsViewModel(passwordItem: passwordItem))
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $viewModel.passwordItem.name)
                        .disabled(!isEditing)
                }
                Section(header: Text("Username/Email")) {
                    TextField("Username/Email", text: $viewModel.passwordItem.username)
                        .disabled(!isEditing)
                }
                Section(header: Text("Password")) {
                    SecureField("Password", text: $viewModel.passwordItem.password)
                        .disabled(!isEditing)
                }
                Section(header: Text("URL")) {
                    TextField("URL", text: $viewModel.passwordItem.url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .disabled(!isEditing)
                }
            }
            .formStyle(.automatic)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Button("Back") {
                            dismiss()
                        }
                        .font(.customFont(font: .lato, style: .medium, size: 16))
                        .disabled(isEditing)

                        Spacer()

                        Text("Details")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .foregroundColor(Color.black)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: false)

                        Spacer()

                        HStack {
                                if isEditing {
                                    Button("Save") {
                                        viewModel.saveChanges()
                                        isEditing = false
                                    }
                                    .font(.customFont(font: .lato, style: .medium, size: 16))
                                } else {
                                    Button("Edit") {
                                        isEditing = true
                                    }
                                    .font(.customFont(font: .lato, style: .medium, size: 16))
                                }
                            }
                            .frame(width: 60)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}


#Preview {
    PasswordDetailsView(passwordItem: PasswordItem.createMockPasswordItem())
}
