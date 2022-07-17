//
//  PriceValidator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import Foundation

/// Price string validator
class PriceValidator: Validator {
    static func validate(str: String) -> Bool {
        if !str.isEmpty {
            return true
        }
        
        return false
    }
}
