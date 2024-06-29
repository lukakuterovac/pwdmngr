//
//  PasswordItem.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation
import FirebaseFirestoreSwift

struct PasswordItem: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var name: String
    var username: String
    var password: String
    var url: String
    
    init(userId: String = "", name: String = "", username: String = "", password: String = "", url: String = "") {
        self.userId = userId
        self.name = name
        self.username = username
        self.password = password
        self.url = url
    }
    
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
