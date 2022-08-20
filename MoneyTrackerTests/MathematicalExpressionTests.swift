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
    
    func testAddExpression() throws {
        let exp = MathematicalExpression(line: "20+10+5+4+1")
        let value = try exp.calculate()
        
        XCTAssertEqual(value, 40.0)
    }
    
    func testSubExpression() throws {
        let exp = MathematicalExpression(line: "25-5-10")
        let value = try exp.calculate()
        
        XCTAssertEqual(value, 10.0)
    }
    
    func testMulExpression() throws {
        let exp = MathematicalExpression(line: "5*3")
        let value = try exp.calculate()
        
        XCTAssertEqual(value, 15.0)
    }
    
    func testDivExpression() throws {
        let exp = MathematicalExpression(line: "20/4")
        let value = try exp.calculate()
        
        XCTAssertEqual(value, 5.0)
    }
    
    func testMultiExpression() throws {
        let exp = MathematicalExpression(line: "10-5*4+20/10")
        let value = try exp.calculate()
        
        XCTAssertEqual(value, 4.0)
    }
}
