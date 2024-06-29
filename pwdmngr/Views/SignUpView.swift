//
//  SignUpView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SignUpViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        let viewModel = SignUpViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
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
            
            InputField(text: $viewModel.confirmPassword, title: "Confirm password", placeholder: "Enter your password again", isSecureField: true)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            
            Button {
                Task {
                    try await authViewModel.signUp(email: viewModel.email, password: viewModel.password, confirmPassword: viewModel.confirmPassword)
                }
            } label: {
                Text("Sign up")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 16)
            .disabled(!viewModel.validateForm())
            
            Spacer()
            
            VStack(spacing: 3) {
                Text("Already have an account?")
                    .font(.system(size: 14))
                Button {
                    dismiss()
                    authViewModel.errorMessage = ""
                } label: {
                    Text("Sign in.")
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


#Preview {
    SignUpView()
}
