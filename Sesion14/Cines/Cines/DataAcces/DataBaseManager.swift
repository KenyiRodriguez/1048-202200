//
//  DataBaseManager.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/02/22.
//

import Foundation
import CoreData

class DataBaseManager {
    
    static let current = DataBaseManager()
    
    var context: NSManagedObjectContext {
        self.persintentContainer.viewContext
    }
    
    lazy private var persintentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Cines")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("ERROR EN LA BASE DE DATOS: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        
        let context = self.persintentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
