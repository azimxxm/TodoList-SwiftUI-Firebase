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
    @Published var filterDayData: [Date] = []
    @Published var isSelectedDay: Int = 0
    @Published var errorMessage: String? = nil
    @Published var hideIscompleted: Bool = false
    @Published var showLogOutMenu: Bool = false
    @Published var showFormView: Bool = false
    
    init() {
        Task {
            await getTodos()
        }
    }
    
    
    var filtredData: [ItemDM] {
        return hideIscompleted ? items.filter({ $0.isCompleted == false }) : items
    }
    
    
    func getTodos() async {
        await FirestoreUserManager.shared.getTodosForCurrentUser(completion: {[weak self] result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let success):
                     self?.items = success
                     self?.dayForFilter(items: success)
                 case .failure(let failure):
                     self?.errorMessage = failure.localizedDescription
                 }
             }
        })
    }
    
    
    func logout() {
        FirebaseAuthManager.shared.signOut()
    }
    
    func addTodo(_ item: ItemDM) async {
        Task {
            do {
                try await FirestoreUserManager.shared.addTodoForCurrentUser(item: item)
                await getTodos()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
    func dayForFilter(items: [ItemDM]) {
        var filterDay: Set<Date> = []
        let calendar = Calendar.current
        
        items.forEach { item in
            if let normalizedDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: item.createdAt)) {
                filterDay.insert(normalizedDate)
            }
        }
        // Assign the unique days to filterDayData
        self.filterDayData = Array(filterDay).sorted()
    }
    
    
    func updateTodo(_ item: ItemDM) async {
        FirestoreUserManager.shared.updateTodoCompletionStatus(todoID: item.id, isCompleted: item.isCompleted) { result in
            switch result {
            case .success(let success):
                if success {
                    self.errorMessage = nil
                } else {
                    self.errorMessage = "Error updating todo"
                }
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
            }
        }
    }

}
