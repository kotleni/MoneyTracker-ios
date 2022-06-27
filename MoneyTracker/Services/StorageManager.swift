//
//  StorageManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: "price_type")
    }
    
    func getPriceType() -> String {
        guard let priceType = UserDefaults.standard.string(forKey: "price_type") else { return "USD" }
        return priceType
    }
}
