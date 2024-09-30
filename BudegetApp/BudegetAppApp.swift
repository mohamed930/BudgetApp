//
//  BudegetAppApp.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

@main
struct BudegetAppApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
