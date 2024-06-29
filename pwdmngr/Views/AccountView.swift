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
                Spacer()
                Text("\(user.email)")
                Button("Sign out") {
                    authViewModel.signOut()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
        } else {
            ProgressView()
                .background(Color(.secondarySystemBackground))
        }
    }
}

#Preview {
    AccountView()
}
