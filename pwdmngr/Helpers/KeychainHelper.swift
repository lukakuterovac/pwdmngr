//
//  KeychainHelper.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 30.06.2024..
//

import Foundation
import Security

//class KeychainHelper {
//    static let shared = KeychainHelper()
//    
//    func saveEmail(_ email: String) {
//        save(key: "email", data: Data(email.utf8))
//    }
//    
//    func savePassword(_ password: String) {
//        save(key: "password", data: Data(password.utf8))
//    }
//    
//    func getEmail() -> String? {
//        return get(key: "email")
//    }
//    
//    func getPassword() -> String? {
//        return get(key: "password")
//    }
//    
//    private func save(key: String, data: Data) {
//        let query = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrAccount: key,
//            kSecValueData: data
//        ] as CFDictionary
//        
//        SecItemDelete(query)
//        SecItemAdd(query, nil)
//    }
//    
//    private func get(key: String) -> String? {
//        let query = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrAccount: key,
//            kSecReturnData: true,
//            kSecMatchLimit: kSecMatchLimitOne
//        ] as CFDictionary
//        
//        var dataTypeRef: AnyObject?
//        let status = SecItemCopyMatching(query, &dataTypeRef)
//        
//        guard status == errSecSuccess else { return nil }
//        guard let data = dataTypeRef as? Data else { return nil }
//        
//        return String(data: data, encoding: .utf8)
//    }
//}

import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    func saveEmail(_ email: String) {
        save(key: "email", data: Data(email.utf8))
    }
    
    func savePassword(_ password: String) {
        save(key: "password", data: Data(password.utf8))
    }
    
    func getEmail() -> String? {
        return get(key: "email")
    }
    
    func getPassword() -> String? {
        return get(key: "password")
    }
    
    private func save(key: String, data: Data) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    private func get(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        guard status == errSecSuccess else { return nil }
        guard let data = dataTypeRef as? Data else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}


