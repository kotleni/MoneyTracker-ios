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
    static func findByCode(array: [Currency], code: String) -> Currency? {
        return array.first { currency in return currency.littleName == code }
    }
    
    /// Find currency by id
    static func findById(array: [Currency], id: UUID) -> Currency? {
        return array.first { currency in return currency.id == id }
    }
}
