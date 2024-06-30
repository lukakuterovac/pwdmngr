//
//  PasswordGeneratorView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI

struct PasswordGeneratorView: View {
    @StateObject private var viewModel = PasswordGeneratorViewModel()
    @ObservedObject private var viewState: PasswordGeneratorViewState
    private var passwordGenerator: PasswordGenerator
    @StateObject private var generatorOptions = GeneratorOptions.getInstance()
    
    init() {
        let viewModel = PasswordGeneratorViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
        self.passwordGenerator = PasswordGenerator()
    }
    
    private var starsCount: String {
        let count = min(viewState.generatedPassword.count, 32)
        return String(repeating: "*", count: count)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack(alignment: .center) {
                            Text("Generated password")
                                .font(.customFont(font: .lato, style: .regular, size: 20))
                            Spacer()
                            Text("Copy")
                                .font(.customFont(font: .lato, style: .regular, size: 16))
                                .foregroundStyle(.blue)
                        }
                        HStack {
                            if viewState.isShowingFullPassword {
                                TextField("Password", text: $viewState.generatedPassword)
                                    .textInputAutocapitalization(.never)
                                    .disabled(true)
                                    .padding()
                            } else {
                                SecureField("Password", text: $viewState.generatedPassword)
                                    .textInputAutocapitalization(.never)
                                    .disabled(true)
                                    .padding()
                            }
                            
                            Spacer()
                            Button(action: {
                                viewState.isShowingFullPassword.toggle()
                            }) {
                                Image(systemName: viewState.isShowingFullPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor { traitCollection in
                                    traitCollection.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground
                                }))
                        )
                    }
                    .padding()
                    
                    Button(action: viewModel.generatePassword) {
                        Text("Generate Password")
                            .font(.customFont(font: .lato, style: .regular, size: .h2))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.anyToggleSelected() ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(!viewModel.anyToggleSelected())
                    
                    VStack {
                        HStack {
                            Text("Options")
                            Spacer()
                            Image(systemName: viewState.isOptionsExpanded ? "chevron.down" : "chevron.up")
                                .transition(.scale)
                        }
                        .onTapGesture {
                            withAnimation {
                                viewState.isOptionsExpanded.toggle()
                            }
                        }
                        
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
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.systemBackground))
                                )
                            }
                            .transition(.scale.combined(with: .opacity))
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.generatePassword()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Generate")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                    }
                }
            }
        }
    }
}

#Preview {
    PasswordGeneratorView()
}
