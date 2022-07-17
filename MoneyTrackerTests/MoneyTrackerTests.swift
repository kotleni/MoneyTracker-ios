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
        let currency = Currency.findByCode(array: Currencies.currenciesAll, code: "USD")
        XCTAssertNotNil(currency)
    }
    
    func testEmojiValidator() throws {
        let first = EmojiValidator.validate(str: "x")
        let second = EmojiValidator.validate(str: "🎉")
        XCTAssertFalse(first)
        XCTAssertTrue(second)
    }
    
    func testTagNameValidator() throws {
        let first = TagNameValidator.validate(str: "")
        let second = TagNameValidator.validate(str: "Example")
        XCTAssertFalse(first)
        XCTAssertTrue(second)
    }
    
    func testPriceValidator() throws {
        let first = PriceValidator.validate(str: "xx")
        let second = PriceValidator.validate(str: "0.0")
        XCTAssertFalse(first)
        XCTAssertTrue(second)
    }
}
