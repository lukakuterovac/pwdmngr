//
//  PasswordDataModel.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 26.06.2024..
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import CryptoSwift

class PasswordDataModel: ObservableObject {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Published var passwordItems: [PasswordItem] = []
    private var db = Firestore.firestore()
    private let key = "01234567890123456789012345678901"
    private let iv = "0123456789012345"
    
    init() { }
    
    func encryptStringAES(_ input: String, key: String, iv: String) throws -> String? {
        guard let keyData = key.data(using: .utf8), keyData.count == 32,
              let ivData = iv.data(using: .utf8), ivData.count == 16 else {
            return nil
        }
        
        do {
            let encrypted = try AES(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7).encrypt(input.bytes)
            
            let encryptedData = Data(encrypted)
            let encryptedString = encryptedData.base64EncodedString()
            
            return encryptedString
        } catch {
            print("Failed to encrypt \(input)")
            print("Encryption error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func addItem(_ item: PasswordItem, completion: @escaping (Error?) -> Void) {
        do {
            guard let encryptedEmail = try encryptStringAES(item.username, key: self.key, iv: self.iv),
                  let encryptedPassword = try encryptStringAES(item.password, key: self.key, iv: self.iv) else {
                completion(NSError(domain: "EncryptionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Encryption failed"]))
                return
            }
            
            passwordItems.append(item)
            
            let encryptedItem = PasswordItem(userId: item.userId, name: item.name, username: encryptedEmail, password: encryptedPassword, url: item.url)
            
            let docRef = db.collection("passwords").document()
            try docRef.setData(from: encryptedItem)
            
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func updateItem(_ item: PasswordItem, completion: @escaping (Error?) -> Void) {
        guard let documentId = item.id else {
            completion(NSError(domain: "PasswordDataModel", code: 0, userInfo: ["message": "Missing item ID"]))
            return
        }
        
        do {
            guard let encryptedEmail = try encryptStringAES(item.username, key: self.key, iv: self.iv),
                  let encryptedPassword = try encryptStringAES(item.password, key: self.key, iv: self.iv) else {
                completion(NSError(domain: "EncryptionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Encryption failed"]))
                return
            }
            
            let encryptedItem = PasswordItem(userId: item.userId, name: item.name, username: encryptedEmail, password: encryptedPassword, url: item.url)
            
            let docRef = db.collection("passwords").document(documentId)
            try docRef.setData(from: encryptedItem)
            
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func deleteItem(_ item: PasswordItem, completion: @escaping (Error?) -> Void) {
        guard let documentId = item.id else {
            completion(NSError(domain: "PasswordDataModel", code: 0, userInfo: ["message": "Missing item ID"]))
            return
        }
        let docRef = db.collection("passwords").document(documentId)
        docRef.delete { error in
            completion(error)
        }
    }
    
    func fetchItems(userId: String, completion: @escaping (Result<[PasswordItem], Error>) -> Void) {
        db.collection("passwords")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documents = querySnapshot?.documents else {
                        completion(.success([]))
                        return
                    }
                    
                    let passwordItems: [PasswordItem] = documents.compactMap { document in
                        do {
                            var decryptedItem = try document.data(as: PasswordItem.self)
                            
                            decryptedItem.username = try self.decryptStringAES(decryptedItem.username, key: self.key, iv: self.iv) ?? decryptedItem.username
                            
                            decryptedItem.password = try self.decryptStringAES(decryptedItem.password, key: self.key, iv: self.iv) ?? decryptedItem.password
                            
                            return decryptedItem
                        } catch {
                            print("Failed to decrypt item: \(error)")
                            return nil
                        }
                    }
                    
                    completion(.success(passwordItems))
                }
            }
    }
    
    private func decryptStringAES(_ encryptedBase64: String, key: String, iv: String) throws -> String? {
        guard let keyData = key.data(using: .utf8), let ivData = iv.data(using: .utf8) else {
            return nil
        }
        
        guard let encryptedData = Data(base64Encoded: encryptedBase64) else {
            return nil
        }
        
        let decrypted = try AES(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7).decrypt(encryptedData.bytes)
        guard let decryptedString = String(bytes: decrypted, encoding: .utf8) else {
            return nil
        }
        
        return decryptedString
    }
    
    func ensureKeyLength(_ key: String) -> String {
        let requiredLength = 32
        if key.count < requiredLength {
            return key.padding(toLength: requiredLength, withPad: "0", startingAt: 0)
        } else if key.count > requiredLength {
            return String(key.prefix(requiredLength))
        }
        return key
    }
    
    func ensureIVLength(_ iv: String) -> String {
        let requiredLength = 16
        if iv.count < requiredLength {
            return iv.padding(toLength: requiredLength, withPad: "0", startingAt: 0)
        } else if iv.count > requiredLength {
            return String(iv.prefix(requiredLength))
        }
        return iv
    }
}
