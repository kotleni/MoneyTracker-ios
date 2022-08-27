//
//  MathematicalExpression.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

enum OperatorType: String {
    case NUM  = "NUM" // number
    
    case ADD = "ADD" // addition
    case SUB = "SUB" // subtraction
    case MUL = "MUL" // multiplication
    case DIV = "DIV" // division
}

protocol OperatorItem {
    var type: OperatorType { get set }
}

class LogicOperatorItem: OperatorItem {
    var type: OperatorType
    
    init(type: OperatorType) {
        self.type = type
    }
}

class NumberOperatorItem: OperatorItem {
    var type: OperatorType = .NUM
    var value: Float
    
    init(value: Float) {
        self.value = value
    }
}

/// Mathemical expression with calucating
class MathematicalExpression {
    private let line: String
    
    init(line: String) {
        self.line = line
    }
    
    /// Parse expression string
    func parse() throws -> [OperatorItem] {
        var operators: [OperatorItem] = []
        
        var buff = ""
        line.forEach { char in
            if char == "+" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .ADD))
                }
                
                buff = ""
            } else if char == "-" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .SUB))
                }
                
                buff = ""
            } else if char == "*" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .MUL))
                }
                
                buff = ""
            } else if char == "/" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .DIV))
                }
                
                buff = ""
            } else {
                buff.append(char)
            }
        }
        
        if !buff.isEmpty {
            if let value = Float(buff.trim()) {
                operators.append(NumberOperatorItem(value: value))
            }
            
            buff = ""
        }
        
        return operators
    }
    
    /// Calculate expression
    func calculate() throws -> Float {
        let operators = try parse()
        var index = 1
        
        if operators.isEmpty {
            throw MathExpressionError.invalidExpression
        }
        
        guard let item = (operators[0] as? NumberOperatorItem) else { throw MathExpressionError.invalidExpression }
        var sum: Float = item.value
        
        while index < operators.count - 1 {
            let opera = operators[index]
            
            if opera.type != .NUM {
                guard let opera = opera as? LogicOperatorItem else { throw MathExpressionError.invalidExpression }
                guard let opNext = operators[index + 1] as? NumberOperatorItem else { throw MathExpressionError.invalidExpression }
                
                switch opera.type {
                case .ADD:
                    sum += opNext.value
                    break
                case .SUB:
                    sum -= opNext.value
                    break
                case .MUL:
                    sum *= opNext.value
                    break
                case .DIV:
                    sum /= opNext.value
                    break
                default:
                    throw MathExpressionError.invalidOperator(opera.type.rawValue)
                }
            }
            
            index += 1
        }
        
        return sum
    }
}
