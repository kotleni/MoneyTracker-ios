//
//  Validator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import Foundation

protocol Validator {
    static func validate(str: String) -> Bool
}
