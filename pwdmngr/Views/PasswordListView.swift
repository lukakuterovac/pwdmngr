//
//  PasswordListView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct PasswordListView: View {
    @ObservedObject var viewModel = PasswordListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.passwordItems) { item in
                    PasswordCard(passwordItem: item)
                }
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Passwords")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}

#Preview {
    PasswordListView()
}
