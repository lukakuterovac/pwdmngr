//
//  PasswordGeneratorViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation
import SwiftUI

class PasswordGeneratorViewState: ObservableObject {
    @Published var isShowingFullPassword: Bool = false
    @Published var isOptionsExpanded: Bool = false
    
    @Published var includeLowercase: Bool = true
    @Published var includeUppercase: Bool = false
    @Published var includeNumbers: Bool = false
    @Published var includeSpecialCharacters: Bool = false
    @Published var passwordLength: Double = 6.0
    
    @Published var generatedPassword: String = ""
}
