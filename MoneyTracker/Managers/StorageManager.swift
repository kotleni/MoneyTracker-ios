//
//  StorageManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import Foundation

/// Data storage manager
final class StorageManager {
    /// Data sotrage keys
    final class Keys {
        static let priceType = "price_type"
        static let notifEnable = "notif_enable"
        static let isExperimental = "is_experimental"
    }
    
    /// Set price type
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: Keys.priceType)
    }
    
    /// Set notifications enable
    func setNotifEnable(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.notifEnable)
    }
    
    /// Set is experimental
    func setExperimental(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.isExperimental)
    }
    
    /// Get price type
    func getPriceType() -> String {
        guard let priceType = UserDefaults.standard.string(forKey: Keys.priceType) else { return Currencies.getDefault() }
        return priceType
    }
    
    /// Check is notifications enable
    func isNotifEnable() -> Bool {
        let isEnable = UserDefaults.standard.bool(forKey: Keys.notifEnable)
        return isEnable
    }
    
    /// Check is experimental
    func isExperimental() -> Bool {
        let isEnabled = UserDefaults.standard.bool(forKey: Keys.isExperimental)
        return isEnabled
    }
}
