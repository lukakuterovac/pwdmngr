//
//  pwdmngrApp.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI
import Firebase

@main
struct pwdmngrApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var dataModel = PasswordDataModel()
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authViewModel)
                .environmentObject(dataModel)
                .onChange(of: scenePhase, handleScenePhaseChange)
        }
    }
    
    func handleScenePhaseChange() {
        switch scenePhase {
        case .background:
            print("App is in the background")
            authViewModel.signOut()
        case .inactive:
            print("App is inactive")
            authViewModel.signOut()
        case .active:
            print("App is active")
        @unknown default:
            break
        }
    }
}

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                MainTabView()
            } else {
                SignInView()
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var dataModel: PasswordDataModel
    
    var body: some View {
        if authViewModel.currentUser != nil {
            TabView {
                PasswordListView()
                    .tabItem {
                        CustomLabel(title: "Passwords", systemImage: "list.dash", font: .customFont(font: .lato, style: .regular))
                    }
                PasswordGeneratorView()
                    .tabItem {
                        CustomLabel(title: "Generator", systemImage: "lock.rotation", font: .customFont(font: .lato, style: .regular))
                    }
                AccountView()
                    .tabItem {
                        CustomLabel(title: "Account", systemImage: "person", font: .customFont(font: .lato, style: .regular))
                    }
            }
        } else {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.secondarySystemBackground))
        }
    }
}
