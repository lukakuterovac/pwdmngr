//
//  GeneratorOptions.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 30.06.2024..
//

import Foundation
import SwiftUI

final class GeneratorOptions: ObservableObject {
    private static let shared = GeneratorOptions()
    @Published var passwordLength: Double
    @Published var includeLowercase: Bool
    @Published var includeUppercase: Bool
    @Published var includeNumbers: Bool
    @Published var includeSpecialCharacters: Bool
    
    private init() {
        passwordLength = 6
        includeLowercase = true
        includeUppercase = false
        includeNumbers = false
        includeSpecialCharacters = false
    }
    
    static func getInstance() -> GeneratorOptions {
        return shared
    }
}
