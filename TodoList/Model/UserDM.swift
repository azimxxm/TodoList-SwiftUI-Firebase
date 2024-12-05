//
//  UserDM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import Foundation
import FirebaseAuth
import SwiftData


@Model
class UserDM: Identifiable, Equatable {
    var id: String
    var name: String
    var email: String
    
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

extension UserDM {
    func toDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "name": self.name,
            "email": self.email
        ]
    }
}
