//
//  NameValidator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

/// Names validator
class TagNameValidator: Validator {
    static func validate(str: String) -> Bool {
        if !str.isEmpty {
            return true
        }
        
        return false
    }
}
