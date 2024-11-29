//
//  LoginScreenVM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

@MainActor
class LoginScreenVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var user: UserDM?
    
    func login() {
        errorMessage = nil
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        Task {
            await FirebaseAuthManager.shared.signIn(with: email, password: password) {[weak self] user in
                DispatchQueue.main.async {
                    switch user {
                    case .success(let user):
                        self?.user = user
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
    
    
    func resetPassword() {
        errorMessage = nil
        guard !email.isEmpty else {
            errorMessage = "Please enter email"
            return
        }
        Task {
            await FirebaseAuthManager.shared.resetPassword(with: email) {[weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        if success {
                            self?.errorMessage = "Password reset email sent"
                        } else {
                            self?.errorMessage = "Failed to send password reset email"
                        }
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
