//
//  OneApp.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

@main
struct OneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
