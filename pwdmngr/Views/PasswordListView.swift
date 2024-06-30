//
//  PasswordListView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import SwiftUI

struct PasswordListView: View {
    @StateObject private var viewModel: PasswordListViewModel
    @ObservedObject private var viewState: PasswordListViewState
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var dataModel: PasswordDataModel
    
    init() {
        let viewModel = PasswordListViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
        _viewState = ObservedObject(wrappedValue: viewModel.viewState)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewState.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.secondarySystemBackground))
                } else {
                    VStack {
                        HStack {
                            Text("Passwords")
                            Spacer()
                            NavigationLink(
                                destination: CreatePasswordView(dataModel: dataModel, authViewModel: authViewModel)
                            ) {
                                Text("Add")
                            }
                        }
                        .padding()
                        
                        if viewState.passwordItems.count > 0 {
                            ScrollView {
                                ForEach(viewState.passwordItems) { item in
                                    NavigationLink(destination: PasswordDetailsView(passwordItem: item, dataModel: dataModel)) {
                                        PasswordCard(passwordItem: item)
                                            .padding(.horizontal)
                                            .padding(.vertical, 3)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                            }
                            .background(Color(.systemGroupedBackground))
                        } else {
                            Spacer()
                            Text("No passwords found.")
                            Spacer()
                        }
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .onAppear {
                viewState.isLoading = true
                if let userId = authViewModel.currentUser?.id {
                    dataModel.fetchItems(userId: userId) { result in
                        defer { viewState.isLoading = false }
                        switch result {
                        case .success(let passwordItems):
                            viewState.passwordItems = passwordItems
                        case .failure(let error):
                            print("Error fetching password items: \(error)")
                        }
                    }
                } else {
                    print("Current user not available for password fetching.")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Text("pwdmngr")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
        }
    }
}


#Preview {
    PasswordListView()
}
