//
//  PasswordItem.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation

struct PasswordItem: Identifiable {
    var id = UUID()
    var name: String
    var username: String
    var password: String
    var url: String
    
    static func createMockPasswordItem() -> PasswordItem {
        return PasswordItem(
            name: "Google",
            username: "mockuser@example.com",
            password: "MockPassword123!",
            url: "https://www.google.com"
        )
    }
    
    static func createMockPasswordItems() -> [PasswordItem] {
        return [
            PasswordItem(
                name: "Google",
                username: "mockuser@example.com",
                password: "MockPassword123!",
                url: "https://www.google.com"
            ),
            PasswordItem(
                name: "YouTube",
                username: "mockuser@example.com",
                password: "MockPassword123!",
                url: "https://www.youtube.com"
            ),
            PasswordItem(
                name: "Facebook",
                username: "mockuser@example.com",
                password: "MockPassword123!",
                url: "https://www.facebook.com"
            ),
            PasswordItem(
                name: "Google 2",
                username: "mockuser@example.com",
                password: "MockPassword123!",
                url: "https://www.google.com"
            ),
        ]
    }
}
