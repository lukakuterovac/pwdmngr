//
//  AccountView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack {
                HStack {
                    Circle()
                        .fill(Color.random())
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(user.email.prefix(2).uppercased())
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        )
                    
                    Text("\(user.email)")
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor { traitCollection in
                            traitCollection.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground
                        }))
                )
                .padding()
                
                VStack {
                    HStack {
                        Text("Actions")
                        Spacer()
                    }
                    
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .font(.customFont(font: .lato, style: .medium, size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(.red)
                    }
                    .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
        } else {
            ProgressView()
                .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    AccountView()
}
