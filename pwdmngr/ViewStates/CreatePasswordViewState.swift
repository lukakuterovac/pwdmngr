//
//  CreatePasswordViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import Foundation

class CreatePasswordViewState: ObservableObject {
    @Published var name: String
    @Published var username: String
    @Published var password: String
    @Published var url: String
    @Published var userId: String
    
    init() {
        self.name = ""
        self.username = ""
        self.password = ""
        self.url = ""
        self.userId = ""
    }
}
