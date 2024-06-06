//
//  PasswordListViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 06.06.2024..
//

import Foundation
import SwiftUI

class PasswordListViewState: ObservableObject {
    @Published var passwordItems: [PasswordItem] = [
        PasswordItem(name: "Google", username: "user@gmail.com", url: "https://www.google.com"),
        PasswordItem(name: "Facebook", username: "user@facebook.com", url: "https://www.facebook.com"),
        PasswordItem(name: "Twitter", username: "user@twitter.com", url: "https://www.twitter.com")
    ]
}
