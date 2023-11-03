//
//  PriceValidator.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 17.07.2022.
//

import Foundation

/// Price string validator
class PriceExpressionValidator: Validator {
    static func validate(str: String) -> Bool {
        if str.isEmpty {
            return false
        }
        
        var isValid = true
        let allowed = "01234567890.+-/* "
        str.forEach { char in
            if !allowed.contains(char) {
                isValid = false
            }
        }
        return isValid
    }
}
