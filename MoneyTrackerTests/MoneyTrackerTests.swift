//
//  MoneyTrackerTests.swift
//  MoneyTrackerTests
//
//  Created by Victor Varenik on 13.07.2022.
//

import XCTest
@testable import MoneyTracker

class MoneyTrackerTests: XCTestCase {
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testCurrencyFind() throws {
        let currency = Currency.findByCode(array: currenciesAll, code: "USD")
        XCTAssertNotNil(currency)
    }
}
