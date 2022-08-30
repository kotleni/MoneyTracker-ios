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
        case runsCount = "runs_count"
    }
    
    /// Set price type
    func setPriceType(type: String) {
        UserDefaults.standard.set(type, forKey: Keys.priceName.rawValue)
    }
    
    /// Set notifications enable
    func setNotifEnable(isEnable: Bool) {
        UserDefaults.standard.set(isEnable, forKey: Keys.notifEnable.rawValue)
    }
    
    /// Increase app runs count
    func increaseRunsCount() {
        let runsCount = getRunsCount()
        UserDefaults.standard.set(runsCount + 1, forKey: Keys.runsCount.rawValue)
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
    
    /// Get app runs count
    func getRunsCount() -> Int {
        let runsCount = UserDefaults.standard.integer(forKey: Keys.runsCount.rawValue)
        return runsCount
    }
}
