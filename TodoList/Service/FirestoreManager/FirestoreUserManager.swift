//
//  FirestoreUserManager.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 30/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

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
    
    func getUserCollection(compliance: @escaping (Result<UserDM, Error>) -> Void) async throws {
        guard let user = Auth.auth().currentUser else { return }
        let snapshoot = try await Firestore.firestore().collection("users").document(user.uid).getDocument()
        
        guard let data = snapshoot.data() else {
            throw URLError(.badServerResponse)
        }
        print(dump(data))
    }
    
}
