//
//  Tag.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import Foundation

extension Tag {
    func getString() -> String {
        return "\(emoji!) \(name!)"
    }
    
    @available(*, deprecated)
    static func getByName(name: String) -> Tag? {
        var result: Tag? = nil
        getAll().forEach { tag in
            if tag.name == name {
                result = tag
            }
        }
        return result
    }
    
    @available(*, deprecated)
    static func getDefault() -> Tag {
        return TagsManager.shared.getDefaultTag()
    }
    
    @available(*, deprecated)
    static func getAll() -> [Tag] {
        return TagsManager.shared.getTags()
    }
}
