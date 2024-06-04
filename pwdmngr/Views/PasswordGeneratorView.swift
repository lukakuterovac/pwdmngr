//
//  PasswordGeneratorView.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import SwiftUI

struct PasswordGeneratorView: View {
    @StateObject private var sensorData = SensorDataViewModel()
    @State private var isShowingFullPassword: Bool = false
    @State private var isOptionsExpanded: Bool = false
    @State private var includeLowercase: Bool = true
    @State private var includeUppercase: Bool = false
    @State private var includeNumbers: Bool = false
    @State private var includeSpecialCharacters: Bool = false
    @State private var passwordLength: Double = 32
    @State private var generatedPassword: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("Generated password")
                                .font(.customFont(font: .lato, style: .regular, size: 20))
                            Spacer()
                        }
                        HStack {
                            if isShowingFullPassword {
                                Text(generatedPassword)
                                    .font(.customFont(font: .lato, style: .regular))
                                    .padding()
                            } else {
                                Text(generatedPassword)
                                    .font(.customFont(font: .lato, style: .regular))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    isShowingFullPassword.toggle()
                                }) {
                                    Image(systemName: isShowingFullPassword ? "eye.slash" : "eye")
                                        .foregroundStyle(.foreground)
                                }
                                
                                Button(action: {
                                    UIPasteboard.general.string = generatedPassword
                                }) {
                                    Image(systemName: "doc.on.clipboard")
                                        .foregroundStyle(.foreground)
                                }
                            }
                            .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                                .background(Color.white.cornerRadius(10))
                        )
                    }
                    .padding()
                    
                    Button(action: generatePassword) {
                        Text("Generate Password")
                            .font(.customFont(font: .lato, style: .regular, size: .h2))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(anyToggleSelected() ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(!anyToggleSelected())
                    
                    DisclosureGroup("Options", isExpanded: $isOptionsExpanded) {
                        VStack(alignment: .leading) {
                            Toggle("Include lowercase letters", isOn: $includeLowercase)
                            Toggle("Include uppercase letters", isOn: $includeUppercase)
                            Toggle("Include numbers", isOn: $includeNumbers)
                            Toggle("Include special characters", isOn: $includeSpecialCharacters)
                            
                            VStack {
                                HStack {
                                    Text("Length")
                                        .font(.customFont(font: .lato, style: .regular))
                                    Spacer()
                                    Text("\(Int(passwordLength))")
                                        .font(.customFont(font: .lato, style: .regular))
                                }
                                Slider(value: $passwordLength, in: 6...256, step: 1) {
                                    Text("Length")
                                        .font(.customFont(font: .lato, style: .regular))
                                } minimumValueLabel: {
                                    Text("6")
                                        .font(.customFont(font: .lato, style: .regular))
                                } maximumValueLabel: {
                                    Text("256")
                                        .font(.customFont(font: .lato, style: .regular))
                                }
                            }
                        }
                        .padding()
                    }
                    .foregroundStyle(.foreground)
                    .padding()
                    
                    Spacer()
                }
                .onAppear {
                    generatePassword()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Generate")
                            .font(.customFont(font: .lato, style: .medium, size: 22))
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
    
    func generatePassword() {
        var characters = ""
        if includeLowercase {
            characters += "abcdefghijklmnopqrstuvwxyz"
        }
        if includeUppercase {
            characters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if includeNumbers {
            characters += "0123456789"
        }
        if includeSpecialCharacters {
            characters += "!@#$%^&*()_+{}|:<>?-=[]\\;',./"
        }
        
        let length = Int(passwordLength)
        if characters.isEmpty {
            generatedPassword = "Select at least one character type"
        } else {
            let seed = sensorData.generateSensorSeed()
            var randomGenerator = SeededRandomNumberGenerator(seed: seed)
            generatedPassword = String((0..<length).compactMap { _ in characters.randomElement(using: &randomGenerator) })
        }
    }
    
    func anyToggleSelected() -> Bool {
        return includeLowercase || includeUppercase || includeNumbers || includeSpecialCharacters
    }
}

#Preview {
    PasswordGeneratorView()
}
