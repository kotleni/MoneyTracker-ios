//
//  Currency.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import Foundation

struct Currency: Identifiable, Hashable {
    let fullName: String
    let littleName: String
    
    let id = UUID()
    
    static func findByCode(array: Array<Currency>, code: String) -> Currency? {
        for curr in array {
            if curr.littleName == code {
                return curr
            }
        }
        
        return nil
    }
    
    static func findById(array: Array<Currency>, id: UUID) -> Currency? {
        for curr in array {
            if curr.id == id {
                return curr
            }
        }
        
        return nil
    }
}
