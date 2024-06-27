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
    
    init() {
        let viewModel = PasswordGeneratorViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
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
                        HStack {
                            Text("Generated password")
                                .font(.customFont(font: .lato, style: .regular, size: 20))
                            Spacer()
                        }
                        HStack {
                            if viewState.isShowingFullPassword {
                                Text(viewState.generatedPassword)
                                    .font(.customFont(font: .lato, style: .regular))
                                    .padding()
                            } else {
                                Text(starsCount)
                                    .font(.customFont(font: .lato, style: .regular))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    viewState.isShowingFullPassword.toggle()
                                }) {
                                    Image(systemName: viewState.isShowingFullPassword ? "eye.slash" : "eye")
                                        .foregroundStyle(.foreground)
                                }
                                
                                
                                Button(action: {
                                    UIPasteboard.general.string = viewState.generatedPassword
                                }) {
                                    Image(systemName: "doc.on.clipboard")
                                        .foregroundStyle(.foreground)
                                }
                            }
                            .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primary, lineWidth: 1)
                                .background(
                                    Color(UIColor.systemBackground).cornerRadius(10)
                                )
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
                    
                    DisclosureGroup("Options", isExpanded: $viewState.isOptionsExpanded) {
                        VStack(alignment: .leading) {
                            Toggle("Include lowercase letters", isOn: $viewState.includeLowercase)
                            Toggle("Include uppercase letters", isOn: $viewState.includeUppercase)
                            Toggle("Include numbers", isOn: $viewState.includeNumbers)
                            Toggle("Include special characters", isOn: $viewState.includeSpecialCharacters)
                            
                            VStack {
                                HStack {
                                    Text("Length")
                                        .font(.customFont(font: .lato, style: .regular))
                                    Spacer()
                                    Text("\(Int(viewState.passwordLength))")
                                        .font(.customFont(font: .lato, style: .regular))
                                }
                                Slider(value: $viewState.passwordLength, in: 6...256, step: 1) {
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
                        .padding()
                    }
                    .foregroundStyle(.primary, .blue)
                    .padding()
                    
                    Spacer()
                }
                .onAppear {
                    viewModel.generatePassword()
                }
            }
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
