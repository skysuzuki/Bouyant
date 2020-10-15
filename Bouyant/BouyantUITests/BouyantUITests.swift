//
//  BouyantUITests.swift
//  BouyantUITests
//
//  Created by Lambda_School_Loaner_204 on 9/30/20.
//

import XCTest

class BouyantUITests: XCTestCase {

    private var app: XCUIApplication {
        return XCUIApplication()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }


    func testLevelPicker() {
        let levelPicker = app.pickerWheels["Advanced"]
        levelPicker.swipeDown()

        XCTAssert(app.pickerWheels["Beginner"].exists)
    }

    func testLbsToKgs() {
        let segmentedControl = app.segmentedControls["WeightSegmentedControl"]
        XCTAssert(segmentedControl.exists)

        let kgsSegmentedButton = app.buttons["kgs"]
        kgsSegmentedButton.tap()

        let weightLabel = app.staticTexts["WeightLabel"]
        let kgsLabel = String(format: "%.2f", 200.0 / 2.2)
        XCTAssertEqual(weightLabel.label, kgsLabel)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
