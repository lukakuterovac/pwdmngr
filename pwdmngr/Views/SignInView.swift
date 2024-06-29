//
//  SignInView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel: SignInViewModel
    
    init() {
        let viewModel = SignInViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .bold()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundColor(.red)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 3)
                        )
                }
                
                InputField(text: $viewModel.email, title: "Email", placeholder: "example@email.com")
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                InputField(text: $viewModel.password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Button {
                    Task {
                        try await authViewModel.signIn(email: viewModel.email, password: viewModel.password)
                    }
                } label: {
                    Text("Sign in")
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 16)
                .disabled(!viewModel.validateForm())
                
                Spacer()
                
                VStack(spacing: 3) {
                    Text("Don't have an account?")
                        .font(.system(size: 14))
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                            .onAppear {
                                authViewModel.errorMessage = ""
                            }
                    } label: {
                        Text("Sign up.")
                            .font(.system(size: 14))
                            .bold()
                    }
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
        }
    }
}

#Preview {
    SignInView()
}
