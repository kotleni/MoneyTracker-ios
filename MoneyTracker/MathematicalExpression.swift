//
//  MathematicalExpression.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

/// Mathemical expression with calucating
class MathematicalExpression {
    private var numbers: [Float] = []
    
    init(line: String) {
        let strs = line.split(separator: "+")
        for str in strs {
            let value = Float(str.replacingOccurrences(of: " ", with: ""))
            if value == nil {
                print("MathematicalExpression wrong number: '\(str)'")
            } else {
                numbers.append(value!)
            }
        }
    }
    
    func makeResult() -> Float {
        var sum: Float = 0.0
        for numb in numbers {
            sum += numb
        }
        return sum
    }
}
