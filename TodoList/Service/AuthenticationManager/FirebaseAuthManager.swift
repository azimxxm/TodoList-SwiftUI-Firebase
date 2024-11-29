//
//  FirebaseAuthManager.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import FirebaseAuth
import SwiftUI

final class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    @AppStorage(SomeKeys.isAuthorized.rawValue) private var isAuthorized: Bool = false
    
    private init() {
        isAuthorized = Auth.auth().currentUser != nil
    }

    func getCurrentUser(complited: @escaping (Result<UserDM, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            complited(.failure(URLError(.badServerResponse)))
            return
        }
        isAuthorized = true
        complited(.success(UserDM(user: user)))
    }

    func signIn(with email: String, password: String, complited: @escaping (Result<UserDM, Error>) -> Void) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            isAuthorized = true
            complited(.success(UserDM(user: result.user)))
        } catch {
            isAuthorized = false
            complited(.failure(error))
        }
    }

    func signOut() {
        Task {
            do {
                try Auth.auth().signOut()
                isAuthorized = false
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }

    func createUser(with email: String, password: String, complited: @escaping (Result<UserDM, Error>) -> Void) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            isAuthorized = true
            complited(.success(UserDM(user: result.user)))
        } catch {
            isAuthorized = false
            complited(.failure(error))
        }
    }
    
    
    func resetPassword(with email: String, complited: @escaping (Result<Bool, Error>) -> Void) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            complited(.success(true))
        } catch {
            complited(.failure(error))
        }
    }
    
    
    func updateUserPassword(with password: String, complited: @escaping (Result<Bool, Error>) -> Void) async {
        do {
            try await Auth.auth().currentUser?.updatePassword(to: password)
            complited(.success(true))
        } catch {
            complited(.failure(error))
        }
    }
    
    
    func updateUserEamil(with email: String, complited: @escaping (Result<Bool, Error>) -> Void) async {
        do {
            try await Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email)
            complited(.success(true))
        } catch {
            complited(.failure(error))
        }
    }
}
