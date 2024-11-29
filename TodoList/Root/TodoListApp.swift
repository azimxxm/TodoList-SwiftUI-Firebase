//
//  TodoListApp.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            ItemDM.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            TodoListScreen()
//                .modelContainer(sharedModelContainer)
        }
    }
}
