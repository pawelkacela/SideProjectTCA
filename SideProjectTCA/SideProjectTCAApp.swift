//
//  SideProjectTCAApp.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import SwiftUI
import CoreData

@main
struct SideProjectTCAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
