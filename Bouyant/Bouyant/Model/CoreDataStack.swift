//
//  CoreDataStack.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer =  {
        // Enter name of Data model here:
        let container = NSPersistentContainer(name: "Bouyant")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    func save(context: NSManagedObjectContext) throws {
        var error: Error?

        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }

        if let error = error { throw error }
    }
}
