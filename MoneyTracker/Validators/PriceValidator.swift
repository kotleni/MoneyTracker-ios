//
//  PriceValidator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import Foundation

/// Price string validator
class PriceValidator: Validator {
    // MARK: todo normal validate
    static func validate(str: String) -> Bool {
        // let price = Float(str.replacingOccurrences(of: ",", with: "."))
        if !str.isEmpty {
            return true
        }
        
        return false
    }
}
