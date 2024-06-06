//
//  PasswordListView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct PasswordListView: View {
    @StateObject private var viewModel = PasswordListViewModel()
    @ObservedObject private var viewState: PasswordListViewState
    
    init() {
        let viewModel = PasswordListViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewState.passwordItems) { item in
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
