//
//  Tag.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

extension Tag {
    /// Get tag string
    func getString() -> String {
        return "\(emoji!) \(name!)"
    }
}
