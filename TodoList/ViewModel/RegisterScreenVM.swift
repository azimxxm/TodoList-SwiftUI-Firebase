//
//  RegisterScreenVM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

@MainActor
class RegisterScreenVM: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    @Published var user: UserDM?
    
    func register() {
        errorMessage = nil
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, password == confirmPassword else {
            errorMessage = "Passwords don't match"
            return
        }
        Task {
            await FirebaseAuthManager.shared.createUser(with: email, password: password) {[weak self] user in
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
}
