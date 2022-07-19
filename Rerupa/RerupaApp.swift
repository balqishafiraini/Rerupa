//
//  RerupaApp.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import SwiftUI

@main
struct RerupaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
