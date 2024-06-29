//
//  PasswordGenerator.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 29.06.2024..
//

import Foundation

class PasswordGenerator {
    private var sensorData: SensorDataManager
    private var generatorOptions: GeneratorOptions
    
    init() {
        self.sensorData = SensorDataManager()
        self.generatorOptions = GeneratorOptions.getInstance()
    }
    
    func generatePassword() -> String {
        var generatedPassword = ""
        
        var characters = ""
        if generatorOptions.includeLowercase {
            characters += "abcdefghijklmnopqrstuvwxyz"
        }
        if generatorOptions.includeUppercase {
            characters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if generatorOptions.includeNumbers {
            characters += "0123456789"
        }
        if generatorOptions.includeSpecialCharacters {
            characters += "!@#$%^&*()_+{}|:<>?-=[]\\;',./"
        }
        
        let length = Int(generatorOptions.passwordLength)
        
        if !characters.isEmpty {
            let seed = sensorData.generateSensorSeed()
            var randomGenerator = SeededRandomNumberGenerator(seed: seed)
            generatedPassword = String((0..<length).compactMap { _ in characters.randomElement(using: &randomGenerator) })
        }
        
        return generatedPassword
    }
}
