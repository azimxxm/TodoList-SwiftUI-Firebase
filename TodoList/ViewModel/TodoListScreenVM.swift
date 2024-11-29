//
//  TodoListScreenVM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftData
import SwiftUI

@MainActor
class TodoListScreenVM: ObservableObject {
    //    @Query  var items: [ItemDM]
    @Published var items: [ItemDM] = []
    @Published var isSelectedDay: Int = 0
    @Published var hideIscompleted: Bool = false
    @Published var showLogOutMenu: Bool = false
    var filtredData: [ItemDM] {
        return hideIscompleted ? items.filter({ $0.isCompleted == false }) : items
    }
    
    
    func logout() {
        Task {
            do {
                try FirebaseAuthManager.shared.signOut()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
}
