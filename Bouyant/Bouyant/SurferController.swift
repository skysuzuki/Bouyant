//
//  SurferController.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import Foundation
import CoreData

enum GuildFactor: Float, CaseIterable {
    case Beginner = 0.50
    case BegInter = 0.46 // (0.49 - 0.43)
    case Intermediate = 0.40 // (0.42 - 0.38)
    case InterAdv = 0.37 // (0.38 - 0.36)
    case Advanced = 0.35 // (0.36 - 0.34)
}

class SurferController {

    private let lbsToKgs: Float = 2.2

    func create(weight: Float, guildFactor: Float) {
        let _ = Surfer(weight: weight, guildFactor: guildFactor)
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving object \(error)")
        }
    }

    func update(for surfer: Surfer, weight: Float, guildFactor: Float) {
        surfer.weight = weight
        surfer.guildFactor = guildFactor
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving object \(error)")
        }
    }

    func calculateLiters(weight: Float, guildFactor: Float, isLbs: Bool = true) -> Float {
        return guildFactor * (isLbs ? (weight / lbsToKgs) : weight)
    }
}
