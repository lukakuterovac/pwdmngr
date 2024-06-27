//
//  pwdmngrApp.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI

@main
struct pwdmngrApp: App {
    @StateObject private var dataModel = PasswordDataModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataModel)
        }
    }
}

struct MainTabView: View {
    
    var body: some View {
        TabView {
            PasswordListView()
                .tabItem {
                    CustomLabel(title: "Passwords", systemImage: "list.dash", font: .customFont(font: .lato, style: .regular))
                }
            
            PasswordGeneratorView()
                .tabItem {
                    CustomLabel(title: "Generator", systemImage: "lock.rotation", font: .customFont(font: .lato, style: .regular))
                }
        }
    }
}
