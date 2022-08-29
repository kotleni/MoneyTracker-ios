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
    enum Keys: String {
        case priceName = "price_type"
        case notifEnable = "notif_enable"
    }
    
    /// Set price type
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: Keys.priceName.rawValue)
    }
    
    /// Set notifications enable
    func setNotifEnable(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.notifEnable.rawValue)
    }
    
    /// Get price type
    func getPriceType() -> String {
        guard let priceType = UserDefaults.standard.string(forKey: Keys.priceName.rawValue)
            else { return Currencies.getDefault() }
        return priceType
    }
    
    /// Check is notifications enable
    func isNotifEnable() -> Bool {
        let isEnable = UserDefaults.standard.bool(forKey: Keys.notifEnable.rawValue)
        return isEnable
    }
}
