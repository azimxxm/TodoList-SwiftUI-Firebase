//
//  ItemDM.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI
import SwiftData


@Model
class ItemDM: Identifiable, Decodable {
    var id: String
    var title: String
    var details: String? = nil
    var isCompleted: Bool
    var createdAt: Date

    // Initializer
    init(id:String, title: String, details: String? = nil, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.details = details
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
    
    required init(from decoder: any Decoder) throws {
        self.id = try decoder.singleValueContainer().decode(String.self)
        self.title = try decoder.singleValueContainer().decode(String.self)
        self.details = try? decoder.singleValueContainer().decode(String.self)
        self.isCompleted = try decoder.singleValueContainer().decode(Bool.self)
        self.createdAt = try decoder.singleValueContainer().decode(Date.self)
    }
}

extension ItemDM {
    func toDictionary() -> [String: Any] {
        [
            "title": title,
            "details": details ?? "",
            "isCompleted": isCompleted,
            "createdAt": createdAt
        ]
    }
}
