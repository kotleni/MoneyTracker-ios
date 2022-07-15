//
//  Tag.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 15.07.2022.
//

import Foundation

enum Tag: String, CaseIterable, Identifiable {
    case food = "tag_food"
    case clothes = "tag_clothes"
    case entertainment = "tag_entertainment"
    case technique = "tag_technique"
    case other = "tag_other"
    
    var id: Self { self }
}

func findTagByString(str: String) -> Tag {
    for tag in Tag.allCases {
        if tag.rawValue == str {
            return tag
        }
    }
    return Tag.other
}
