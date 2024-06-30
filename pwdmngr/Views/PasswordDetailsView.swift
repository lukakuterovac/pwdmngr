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
    
    private var passwordGenerator: PasswordGenerator = PasswordGenerator()
    @StateObject private var generatorOptions = GeneratorOptions.getInstance()
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
                        .textInputAutocapitalization(.never)
                        .disabled(!isEditing)
                }
                Section(header: Text("Username/Email")) {
                    TextField("Username/Email", text: $editingPasswordItem.username)
                        .textInputAutocapitalization(.never)
                        .disabled(!isEditing)
                }

                Section(header: Text("Password")) {
                    HStack {
                        if viewState.isShowingFullPassword {
                            TextField("Password", text: $editingPasswordItem.password)
                                .textInputAutocapitalization(.never)
                                .disabled(!isEditing)
                        } else {
                            SecureField("Password", text: $editingPasswordItem.password)
                                .textInputAutocapitalization(.never)
                                .disabled(!isEditing)
                        }

                        Button(action: {
                            viewState.isShowingFullPassword.toggle()
                        }) {
                            Image(systemName: viewState.isShowingFullPassword ? "eye.slash" : "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                if isEditing {
                    Button(action: {
                        print("Generate")
                        self.editingPasswordItem.password = passwordGenerator.generatePassword()
                    }) {
                        HStack {
                            Spacer()
                            Text("Generate")
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(EdgeInsets())
                    
                    VStack {
                        HStack {
                            Text("Options")
                            Spacer()
                            Image(systemName: viewState.isOptionsExpanded ? "chevron.down" : "chevron.up")
                        }
                        .onTapGesture {
                            viewState.isOptionsExpanded.toggle()
                        }
                        
                        VStack{
                            if viewState.isOptionsExpanded {
                                VStack {
                                    Toggle("Include lowercase letters", isOn: $generatorOptions.includeLowercase)
                                    Toggle("Include uppercase letters", isOn: $generatorOptions.includeUppercase)
                                    Toggle("Include numbers", isOn: $generatorOptions.includeNumbers)
                                    Toggle("Include special characters", isOn: $generatorOptions.includeSpecialCharacters)
                                    
                                    VStack {
                                        HStack {
                                            Text("Length")
                                                .font(.customFont(font: .lato, style: .regular))
                                            Spacer()
                                            Text("\(Int(generatorOptions.passwordLength))")
                                                .font(.customFont(font: .lato, style: .regular))
                                        }
                                        Slider(value: $generatorOptions.passwordLength, in: 6...256, step: 1) {
                                            Text("Length")
                                                .font(.customFont(font: .lato, style: .regular))
                                        } minimumValueLabel: {
                                            Text("6")
                                                .font(.customFont(font: .lato, style: .regular))
                                        } maximumValueLabel: {
                                            Text("256")
                                                .font(.customFont(font: .lato, style: .regular))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Section(header: Text("URL")) {
                    TextField("URL", text: $editingPasswordItem.url)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
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
