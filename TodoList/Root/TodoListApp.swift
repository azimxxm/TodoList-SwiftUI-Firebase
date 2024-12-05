//
//  TodoListApp.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI
import SwiftData
import SwiftfulRouting

@main
struct TodoListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ItemDM.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @AppStorage(SomeKeys.isAuthorized.rawValue) private var isAuthorized: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RouterView {_ in
                if isAuthorized {
                    TodoListScreen()
                        .modelContainer(sharedModelContainer)
                        .preferredColorScheme(.light)
                } else {
                    GetStartedScreen()
                        .preferredColorScheme(.light)
                }
            }
        }
    }
}

