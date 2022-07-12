//
//  StorageManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import Foundation

class StorageManager {
    class Keys {
        static let priceType = "price_type"
        static let notifEnable = "notifEnable"
    }
    
    static let shared = StorageManager()
    
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: Keys.priceType)
    }
    
    func getPriceType() -> String {
        guard let priceType = UserDefaults.standard.string(forKey: Keys.priceType) else { return "USD" }
        return priceType
    }
    
    func setNotifEnable(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.notifEnable)
    }
    
    func isNotifEnable() -> Bool {
        let isEnable = UserDefaults.standard.bool(forKey: Keys.notifEnable)
        return isEnable
    }
}
