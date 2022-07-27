//
//  MathematicalExpression.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

/// Mathemical expression with calucating (only sum)
class MathematicalExpression {
    private let line: String
    
    init(line: String) {
        self.line = line
    }
    
    /// Parse expression string
    func parse() -> [Float] {
        var numbers: [Float] = []
        let strs = line.split(separator: "+")
        for str in strs {
            let value = Float(str.replacingOccurrences(of: " ", with: ""))
            if value == nil {
                print("MathematicalExpression wrong number: '\(str)'")
            } else {
                numbers.append(value!)
            }
        }
        
        return numbers
    }
    
    /// Calculate expression
    func calculate() -> Float {
        let values = parse()
        var sum: Float = 0.0
        for value in values {
            sum += value
        }
        return sum
    }
}
