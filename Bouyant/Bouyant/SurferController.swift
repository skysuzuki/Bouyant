//
//  SurferController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import Foundation
import CoreData

class SurferController {

    func update(for surfer: Surfer, weight: Float, guildFactor: Float) {
        surfer.weight = weight
        surfer.guildFactor = guildFactor
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving object \(error)")
        }
    }
}
