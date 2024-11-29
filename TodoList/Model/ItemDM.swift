//
//  ItemDM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

class ItemDM: Identifiable, ObservableObject {
    var id = UUID().uuidString
    var title: String
    var details: String? = nil
    @Published var isCompleted: Bool
    var createdAt: Date

    // Initializer
    init(title: String, details: String? = nil, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.title = title
        self.details = details
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
