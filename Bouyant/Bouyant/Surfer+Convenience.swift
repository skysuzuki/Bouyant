//
//  Surfer+Convenience.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 10/1/20.
//

import Foundation
import CoreData

extension Surfer {

    convenience init(weight: Float,
                     guildFactor: Float,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.weight = weight
        self.guildFactor = guildFactor
    }
}
