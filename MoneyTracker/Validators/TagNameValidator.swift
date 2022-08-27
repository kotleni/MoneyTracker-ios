//
//  NameValidator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

/// Names validator
class TagNameValidator: Validator {
    // MARK: todo normal validate
    static func validate(str: String) -> Bool {
        if str.count > 2 {
            return true
        }
        return false
    }
}
