//
//  Currency.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import Foundation

/// Currency
struct Currency: Identifiable, Hashable {
    let fullName: String
    let littleName: String
    
    let id = UUID()
    
    /// Find currency by code
    static func findByCode(array: Array<Currency>, code: String) -> Currency? {
        for curr in array {
            if curr.littleName == code {
                return curr
            }
        }
        
        return nil
    }
    
    /// Find currency by id
    static func findById(array: Array<Currency>, id: UUID) -> Currency? {
        for curr in array {
            if curr.id == id {
                return curr
            }
        }
        
        return nil
    }
}
