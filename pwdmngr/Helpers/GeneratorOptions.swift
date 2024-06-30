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
    
    @Published var passwordLength: Double {
        didSet {
            UserDefaults.standard.set(passwordLength, forKey: "passwordLength")
        }
    }
    @Published var includeLowercase: Bool {
        didSet {
            UserDefaults.standard.set(includeLowercase, forKey: "includeLowercase")
        }
    }
    @Published var includeUppercase: Bool {
        didSet {
            UserDefaults.standard.set(includeUppercase, forKey: "includeUppercase")
        }
    }
    @Published var includeNumbers: Bool {
        didSet {
            UserDefaults.standard.set(includeNumbers, forKey: "includeNumbers")
        }
    }
    @Published var includeSpecialCharacters: Bool {
        didSet {
            UserDefaults.standard.set(includeSpecialCharacters, forKey: "includeSpecialCharacters")
        }
    }
    
    private init() {
        self.passwordLength = UserDefaults.standard.double(forKey: "passwordLength")
        self.includeLowercase = UserDefaults.standard.bool(forKey: "includeLowercase")
        self.includeUppercase = UserDefaults.standard.bool(forKey: "includeUppercase")
        self.includeNumbers = UserDefaults.standard.bool(forKey: "includeNumbers")
        self.includeSpecialCharacters = UserDefaults.standard.bool(forKey: "includeSpecialCharacters")
        
        if UserDefaults.standard.object(forKey: "passwordLength") == nil {
            self.passwordLength = 6
        }
        if UserDefaults.standard.object(forKey: "includeLowercase") == nil {
            self.includeLowercase = true
        }
        if UserDefaults.standard.object(forKey: "includeUppercase") == nil {
            self.includeUppercase = false
        }
        if UserDefaults.standard.object(forKey: "includeNumbers") == nil {
            self.includeNumbers = false
        }
        if UserDefaults.standard.object(forKey: "includeSpecialCharacters") == nil {
            self.includeSpecialCharacters = false
        }
    }
    
    static func getInstance() -> GeneratorOptions {
        return shared
    }
}

