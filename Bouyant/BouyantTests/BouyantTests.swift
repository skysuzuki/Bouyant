//
//  BouyantTests.swift
//  BouyantTests
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import XCTest
@testable import Bouyant

class BouyantTests: XCTestCase {

    // Test Creating a surfer and updating it
    func testUpdateSurfer() {
        let surfboardController = SurferController()
        let surfer = surfboardController.create(weight: 100.0, guildFactor: GuildFactor.Intermediate.rawValue, isLbs: false)

        XCTAssertFalse(surfer.isLbs)
        XCTAssertEqual(surfer.weight, 100.0)
        XCTAssertEqual(surfer.guildFactor, GuildFactor.Intermediate.rawValue)

        surfboardController.update(for: surfer, weight: 200.0, guildFactor: GuildFactor.Advanced.rawValue, isLbs: true)

        XCTAssertTrue(surfer.isLbs)
        XCTAssertEqual(surfer.weight, 200.0)
        XCTAssertEqual(surfer.guildFactor, GuildFactor.Advanced.rawValue)
    }

    // Test creating a surfer, creating a surfboard, updating the surfboard
    func testUpdateSurfboard() {
        let surfboardController = SurferController()
        let surfer = surfboardController.create(weight: 100.0, guildFactor: GuildFactor.Intermediate.rawValue, isLbs: false)

        let surfboard = surfboardController.createSurfboard(liters: 20.0, surfer: surfer)

        XCTAssertEqual(surfboard.liters, 20.0)
        XCTAssertEqual(surfboard.surfer, surfer)

        surfboardController.updateSurfboard(for: surfboard, liters: 40.0)

        XCTAssertEqual(surfboard.liters, 40.0)
    }
}
