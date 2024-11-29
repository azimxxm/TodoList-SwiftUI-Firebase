//
//  UserDM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import Foundation
import FirebaseAuth

struct UserDM: Identifiable, Equatable {
    let id: String
    let name: String
    let email: String
    
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(user: AuthDataResult) {
        self.id = user.user.uid
        self.name = user.user.displayName ?? ""
        self.email = user.user.email ?? ""
    }
    
    
    init(user: User) {
        self.id = user.uid
        self.name = user.displayName ?? ""
        self.email = user.email ?? ""
    }
}
