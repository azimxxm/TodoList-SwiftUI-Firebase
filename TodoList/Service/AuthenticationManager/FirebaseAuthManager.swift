//
//  FirebaseAuthManager.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import FirebaseAuth
import Foundation

final class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()

    private init() {}

    func getCurrentUser(complited: @escaping (UserDM) -> Void) throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        complited(UserDM(user: user))
    }

    func signIn(with email: String, password: String, complited: @escaping (UserDM) -> Void) async throws {
        let user = try await Auth.auth().signIn(withEmail: email, password: password)
        complited(UserDM(user: user))
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func createUser(with email: String, password: String, complited: @escaping (UserDM) -> Void) async throws {
        let user = try await Auth.auth().createUser(withEmail: email, password: password)
        complited(UserDM(user: user))
    }
}
