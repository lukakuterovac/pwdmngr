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
    private var sensorData: SensorDataManager
    @Published var viewState: PasswordGeneratorViewState
    private let userDefaults = UserDefaults.standard
    
    init(viewState: PasswordGeneratorViewState = PasswordGeneratorViewState(), sensorData: SensorDataManager = SensorDataManager()) {
        self.viewState = viewState
        self.sensorData = sensorData
        // loadUserDefaults()
    }
    
    func loadUserDefaults() {
        viewState.includeLowercase = userDefaults.bool(forKey: "includeLowercase")
        viewState.includeUppercase = userDefaults.bool(forKey: "includeUppercase")
        viewState.includeNumbers = userDefaults.bool(forKey: "includeNumbers")
        viewState.includeSpecialCharacters = userDefaults.bool(forKey: "includeSpecialCharacters")
        viewState.passwordLength = userDefaults.double(forKey: "passwordLength")
    }
    
    func saveUserDefaults() {
        userDefaults.set(viewState.includeLowercase, forKey: "includeLowercase")
        userDefaults.set(viewState.includeUppercase, forKey: "includeUppercase")
        userDefaults.set(viewState.includeNumbers, forKey: "includeNumbers")
        userDefaults.set(viewState.includeSpecialCharacters, forKey: "includeSpecialCharacters")
        userDefaults.set(viewState.passwordLength, forKey: "passwordLength")
    }
    
    func generatePassword() {
        var characters = ""
        if viewState.includeLowercase {
            characters += "abcdefghijklmnopqrstuvwxyz"
        }
        if viewState.includeUppercase {
            characters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if viewState.includeNumbers {
            characters += "0123456789"
        }
        if viewState.includeSpecialCharacters {
            characters += "!@#$%^&*()_+{}|:<>?-=[]\\;',./"
        }
        
        let length = Int(viewState.passwordLength)
        if !characters.isEmpty {
            let seed = sensorData.generateSensorSeed()
            var randomGenerator = SeededRandomNumberGenerator(seed: seed)
            viewState.generatedPassword = String((0..<length).compactMap { _ in characters.randomElement(using: &randomGenerator) })
        }
    }
    
    func anyToggleSelected() -> Bool {
        return viewState.includeLowercase || viewState.includeUppercase || viewState.includeNumbers || viewState.includeSpecialCharacters
    }
}

