//
//  MathematicalExpressionTests.swift
//  MoneyTrackerTests
//
//  Created by Victor Varenik on 09.08.2022.
//

import Foundation

import XCTest
@testable import MoneyTracker

class MathematicalExpressionTests: XCTestCase {
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
    func testSimpleExp() throws {
        let exp = MathematicalExpression(line: "20+10+5+4+1")
        let value = exp.calculate()
        
        XCTAssertEqual(value, 40.0)
    }
}
