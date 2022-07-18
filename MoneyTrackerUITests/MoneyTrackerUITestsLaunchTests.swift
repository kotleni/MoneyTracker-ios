//
//  MoneyTrackerUITestsLaunchTests.swift
//  MoneyTrackerUITests
//
//  Created by Victor Varenik on 18.07.2022.
//

import XCTest

class MoneyTrackerUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments.append("--libiScreenshots")
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
