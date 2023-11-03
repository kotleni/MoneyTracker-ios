//
//  ValidatorsTests.swift
//  MoneyTrackerTests
//
//  Created by Viktor Varenik on 13.07.2022.
//

import XCTest
@testable import MoneyTracker

class ValidatorsTests: XCTestCase {
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
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
    
    func testPriceExpressionValidator() throws {
        let validExpressions = [
            "20+30-7+100/3*321",
            "20",
            "700+10",
            "3.1",
            "3.01/7"
        ]
        let invalidExpressions = [
            "20+30^",
            "",
            "333l"
        ]
        validExpressions.forEach { str in
            let isValid = PriceExpressionValidator.validate(str: str)
            XCTAssertTrue(isValid)
        }
        invalidExpressions.forEach { str in
            let isValid = PriceExpressionValidator.validate(str: str)
            XCTAssertFalse(isValid)
        }
    }
}
