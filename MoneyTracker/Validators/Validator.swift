//
//  Validator.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 17.07.2022.
//

import Foundation

/// Base protocol for validators
protocol Validator {
    static func validate(str: String) -> Bool
}
