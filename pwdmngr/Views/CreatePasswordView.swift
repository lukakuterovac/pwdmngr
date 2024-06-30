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
    private var passwordGenerator: PasswordGenerator
    @StateObject private var generatorOptions = GeneratorOptions.getInstance()
    
    
    init(dataModel: PasswordDataModel, authViewModel: AuthViewModel) {
        let viewModel = CreatePasswordViewModel(dataModel: dataModel, authViewModel: authViewModel)
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
        self.passwordGenerator = PasswordGenerator()
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
                        HStack {
                            if viewState.isShowingFullPassword {
                                TextField("Password", text: $viewState.password)
                                    .textInputAutocapitalization(.never)
                            } else {
                                SecureField("Password", text: $viewState.password)
                                    .textInputAutocapitalization(.never)
                            }

                            Button(action: {
                                viewState.isShowingFullPassword.toggle()
                            }) {
                                Image(systemName: viewState.isShowingFullPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Button(action: {
                        print("Copy")
                        UIPasteboard.general.string = viewState.password
                    }) {
                        HStack {
                            Spacer()
                            Text("Copy")
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(.green)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(EdgeInsets())
                    
                    Button(action: {
                        print("Generate")
                        self.viewState.password = passwordGenerator.generatePassword()
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
