//
//  StorageManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import Foundation

/// Data storage manager
class StorageManager {
    class Keys {
        static let priceType = "price_type"
        static let notifEnable = "notif_enable"
        static let isDeveloper = "is_developer"
    }
    
    @available(*, deprecated)
    static let shared = StorageManager()
    
    /// Set price type
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: Keys.priceType)
    }
    
    /// Get price type
    func getPriceType() -> String {
        guard let priceType = UserDefaults.standard.string(forKey: Keys.priceType) else { return "USD" }
        return priceType
    }
    
    /// Set notifications enable
    func setNotifEnable(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.notifEnable)
    }
    
    /// Check is notifications enable
    func isNotifEnable() -> Bool {
        let isEnable = UserDefaults.standard.bool(forKey: Keys.notifEnable)
        return isEnable
    }
    
    /// Set is developer
    func setDeveloper(isDeveloper: Bool) {
        UserDefaults.standard.set(isDeveloper, forKey: Keys.isDeveloper)
    }
    
    /// Check is developer
    func isDeveloper() -> Bool {
        let isDeveloper = UserDefaults.standard.bool(forKey: Keys.isDeveloper)
        return isDeveloper
    }
}
