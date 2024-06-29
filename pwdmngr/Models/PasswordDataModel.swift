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

class PasswordDataModel: ObservableObject {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Published var passwordItems: [PasswordItem] = []
    private var db = Firestore.firestore()
    
    init() { }
    
    func addItem(_ item: PasswordItem, completion: @escaping (Error?) -> Void) {
      let docRef = db.collection("passwords").document()
      do {
        try docRef.setData(from: item)
        completion(nil)
      } catch let error {
        completion(error)
      }
    }
    
    func updateItem(_ item: PasswordItem, completion: @escaping (Error?) -> Void) {
      guard let documentId = item.id else {
        completion(NSError(domain: "PasswordDataModel", code: 0, userInfo: ["message": "Missing item ID"]))
        return
      }
      let docRef = db.collection("passwords").document(documentId)
      do {
        try docRef.setData(from: item)
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
                    let passwordItems = documents.compactMap { document -> PasswordItem? in
                        try? document.data(as: PasswordItem.self)
                    }
                    completion(.success(passwordItems))
                }
            }
    }
}
