//
//  Surfboard+Convenience.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 10/12/20.
//

import Foundation
import CoreData

extension Surfboard {

    @discardableResult convenience init(liters: Float,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.liters = liters
    }
}
