//
//  PasswordGeneratorViewModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation
import SwiftUI
import Combine

class PasswordGeneratorViewModel: ObservableObject {
    @Published var viewState: PasswordGeneratorViewState
    private let userDefaults = UserDefaults.standard
    private let passwordGenerator: PasswordGenerator
    
    init(viewState: PasswordGeneratorViewState = PasswordGeneratorViewState()) {
        self.viewState = viewState
        self.passwordGenerator = PasswordGenerator()
        // loadUserDefaults()
    }
    
//    func loadUserDefaults() {
//        viewState.includeLowercase = userDefaults.bool(forKey: "includeLowercase")
//        viewState.includeUppercase = userDefaults.bool(forKey: "includeUppercase")
//        viewState.includeNumbers = userDefaults.bool(forKey: "includeNumbers")
//        viewState.includeSpecialCharacters = userDefaults.bool(forKey: "includeSpecialCharacters")
//        viewState.passwordLength = userDefaults.double(forKey: "passwordLength")
//    }
    
//    func saveUserDefaults() {
//        userDefaults.set(viewState.includeLowercase, forKey: "includeLowercase")
//        userDefaults.set(viewState.includeUppercase, forKey: "includeUppercase")
//        userDefaults.set(viewState.includeNumbers, forKey: "includeNumbers")
//        userDefaults.set(viewState.includeSpecialCharacters, forKey: "includeSpecialCharacters")
//        userDefaults.set(viewState.passwordLength, forKey: "passwordLength")
//    }
    
    func generatePassword() {
        let password = passwordGenerator.generatePassword()
        
        viewState.generatedPassword = password
    }
    
    func anyToggleSelected() -> Bool {
        let generatorOptions = GeneratorOptions.getInstance()
        
        return generatorOptions.includeLowercase || generatorOptions.includeUppercase || generatorOptions.includeNumbers || generatorOptions.includeSpecialCharacters
    }
}

