//
//  MathematicalExpression.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

enum OperatorType {
    case NUM // number
    
    case ADD // addition
    case SUB // subtraction
    case MUL // multiplication
    case DIV // division
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
    func parse() -> [OperatorItem] {
        var operators: [OperatorItem] = []
        
        var buff = ""
        line.forEach { ch in
            if ch == "+" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .ADD))
                }
                
                buff = ""
            } else if ch == "-" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .SUB))
                }
                
                buff = ""
            } else if ch == "*" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .MUL))
                }
                
                buff = ""
            } else if ch == "/" {
                if let value = Float(buff.trim()) {
                    operators.append(NumberOperatorItem(value: value))
                    operators.append(LogicOperatorItem(type: .DIV))
                }
                
                buff = ""
            } else {
                buff.append(ch)
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
    func calculate() -> Float {
        let operators = parse()
        var index = 1
        
        var sum: Float = (operators[0] as! NumberOperatorItem).value
        
        while index < operators.count - 1 {
            let op = operators[index]
            
            if op.type != .NUM {
                let op = op as! LogicOperatorItem
                let opNext = operators[index + 1] as! NumberOperatorItem
                
                switch op.type {
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
                    fatalError("To-do error")
                    break
                }
            }
            
            index += 1
        }
        
        return sum
    }
}
