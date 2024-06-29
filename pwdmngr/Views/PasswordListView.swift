//
//  PasswordListView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct PasswordListView: View {
    @EnvironmentObject private var dataModel: PasswordDataModel
    @StateObject private var viewModel: PasswordListViewModel
    @ObservedObject private var viewState: PasswordListViewState
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    init() {
        let viewModel = PasswordListViewModel(passwordItems: [])
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewState.passwordItems.description)
                ScrollView {
                    ForEach(viewState.passwordItems) { item in
                        NavigationLink(destination: PasswordDetailsView(passwordItem: item, dataModel: dataModel)
                        ) {
                            PasswordCard(passwordItem: item)
                                .padding(.horizontal)
                                .padding(.vertical, 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        
                        Text("Passwords")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Spacer()
                    }
                }
            }
        }
        .environmentObject(dataModel)
        .onAppear{
            updateViewState()
        }
        .onReceive(dataModel.objectWillChange) {
            updateViewState()
        }
    }
    
    private func updateViewState() {
        viewState.passwordItems = dataModel.passwordItems
    }
}

#Preview {
    PasswordListView()
}
