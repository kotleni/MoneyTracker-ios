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
    
    /// Get default tag (deprecated)
    @available(*, deprecated)
    static func getDefault() -> Tag {
        return TagsManager.shared.getDefaultTag()
    }
    
    /// Get all tags (deprecated)
    @available(*, deprecated)
    static func getAll() -> [Tag] {
        return TagsManager.shared.getTags()
    }
}
