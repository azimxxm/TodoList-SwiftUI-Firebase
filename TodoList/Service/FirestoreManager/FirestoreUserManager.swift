//
//  FirestoreUserManager.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 30/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

final class FirestoreUserManager {
    static let shared = FirestoreUserManager()
    private init() {}
    
    
    func createNewUserCollection(compliance: @escaping (Result<UserDM, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        let userDM = UserDM(user: user)
        
        Firestore.firestore().collection("users").document(userDM.id).setData(userDM.toDictionary()) { error in
            if let error {
                print("Error creating new user: \(error.localizedDescription)")
            }
        }
    }
    
    
    func addTodoForCurrentUser(item: ItemDM) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "AuthenticationError", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }

        try await Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .collection("todos")
            .addDocument(data: item.toDictionary())
    }

    
    func getTodosForCurrentUser(completion: @escaping (Result<[ItemDM], Error>) -> Void) async {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthenticationError", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }

        do {
            // Foydalanuvchining todos kolleksiyasini o'qish
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .collection("todos")
                .getDocuments()

            // Hujjatlarni modelga aylantirish
            let todos = snapshot.documents.map { document -> ItemDM in
                let data = document.data()
                return ItemDM(
                    id: document.documentID,
                    title: data["title"] as? String ?? "",
                    details: data["details"] as? String ?? "",
                    isCompleted: data["isCompleted"] as? Bool ?? false,
                    createdAt: DateFormatterHelp.shared.getCreatedAtFirebaseTimestampToDate(data: data)
                )
            }

            completion(.success(todos))
        } catch {
            completion(.failure(error))
        }
    }

    
    func updateTodoCompletionStatus(todoID: String, isCompleted: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthenticationError", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }
        
        let documentRef = Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .collection("todos")
            .document(todoID)
        
        documentRef.updateData(["isCompleted": isCompleted]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

    
    
    func deleteTodoByID(todoID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthenticationError", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }
        
        // Reference to the specific document in Firestore
        let documentRef = Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .collection("todos")
            .document(todoID)
        
        // Delete the document
        documentRef.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }


    
}
