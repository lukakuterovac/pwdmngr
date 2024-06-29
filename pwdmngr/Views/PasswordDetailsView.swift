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
    @ObservedObject private var viewState: PasswordDetailsViewState
    
    @EnvironmentObject var dataModel: PasswordDataModel
    @State private var isEditing = false
    @State private var editingPasswordItem: PasswordItem
    
    init(passwordItem: PasswordItem, dataModel: PasswordDataModel) {
        let viewModel = PasswordDetailsViewModel(passwordItem: passwordItem, dataModel: dataModel)
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
        editingPasswordItem = passwordItem
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $editingPasswordItem.name)
                        .disabled(!isEditing)
                }
                Section(header: Text("Username/Email")) {
                    TextField("Username/Email", text: $editingPasswordItem.username)
                        .disabled(!isEditing)
                }
                Section(header: Text("Password")) {
                    SecureField("Password", text: $editingPasswordItem.password)
                        .disabled(!isEditing)
                }
                Section(header: Text("URL")) {
                    TextField("URL", text: $editingPasswordItem.url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .disabled(!isEditing)
                }
                Section(header: Text("Actions")) {
                    Button(action: {
                        dismiss()
                        viewModel.deleteItem()
                    }) {
                        HStack {
                            Spacer()
                            Text("Delete")
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .foregroundColor(.white) // Ensure text is visible on colored background
                            Spacer()
                        }
                        .padding()
                        .background(isEditing ? .gray : .red)
                    }
                    .buttonStyle(PlainButtonStyle()) // Ensures the button does not have extra styling
                    
                    Button(action: {
                        print("Favorite")
                    }) {
                        HStack {
                            Spacer()
                            Text("Favorite")
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .foregroundColor(.white) // Ensure text is visible on colored background
                            Spacer()
                        }
                        .padding()
                        .background(isEditing ? .gray : .green)
                    }
                    .buttonStyle(PlainButtonStyle()) // Ensures the button does not have extra styling
                }
                .listRowInsets(EdgeInsets()) // Removes the default insets of the Section
            }
            .formStyle(.automatic)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        HStack {
                            if isEditing {
                                Button("Cancel") {
                                    editingPasswordItem = viewState.passwordItem
                                    isEditing = false
                                }
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                            } else {
                                Button("Back") {
                                    dismiss()
                                }
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .disabled(isEditing)
                            }
                        }
                        .frame(width: 60)
                        
                        Spacer()
                        
                        Text("Details")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Spacer()
                        
                        HStack {
                            if isEditing {
                                Button("Save") {
                                    viewModel.saveChanges(passwordItem: editingPasswordItem)
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
    PasswordDetailsView(passwordItem: PasswordItem.createMockPasswordItem(), dataModel: PasswordDataModel())
}
