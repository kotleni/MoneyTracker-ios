//
//  EmojiValidator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

/// Emoji validator
class EmojiValidator: Validator {
    // MARK: todo normal validate
    static func validate(str: String) -> Bool {
        if !str.isEmpty && str.count == 1 && str.isSingleEmoji {
            return true
        }
        
        return false
    }
}
