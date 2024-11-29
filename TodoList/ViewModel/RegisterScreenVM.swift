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
    @Published var user: UserDM?
    @AppStorage(SomeKeys.isAuthorized.rawValue) private var isAuthorized: Bool = false
    
    func register() {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, password == confirmPassword else { return }
        Task {
            do {
                try await FirebaseAuthManager.shared.createUser(with: email, password: password) {[weak self] user in
                    self?.user = user
                    self?.isAuthorized = true
                }
            } catch {
                print("Error while registering: \(error.localizedDescription)")
            }
        }
    }
}
