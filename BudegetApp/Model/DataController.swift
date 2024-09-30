//
//  DataController.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 30/09/2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TransActionData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
