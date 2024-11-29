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
    @Published var user: UserDM?
    @AppStorage(SomeKeys.isAuthorized.rawValue) private var isAuthorized: Bool = false
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else { return }
        Task {
            do {
                try await FirebaseAuthManager.shared.signIn(with: email, password: password) {[weak self] user in
                    self?.user = user
                    self?.isAuthorized = true
                }
            } catch {
                print("Error signing in: \(error.localizedDescription)")
            }
        }
    }
}
