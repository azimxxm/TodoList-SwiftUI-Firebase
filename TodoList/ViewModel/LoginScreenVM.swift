//
//  LoginScreenVM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

class LoginScreenVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
