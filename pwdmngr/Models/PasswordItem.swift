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
    var url: String
}
