//
//  SettingsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI
import Combine

class SettingsViewModel: BaseViewModel {
    @Published private(set) var isDeveloper: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var currency: String = ""
    
    /// Load data
    override func loadData() {
        currency = storageManager.getPriceType()
        isDeveloper = storageManager.isDeveloper()
        
        // Check if product saved in keychain
        if let data = keychainManager.read(key: Static.subsExpirationKeychain),
           let expirationTimeInteval = try? JSONDecoder().decode(TimeInterval.self, from: data) {
            let subscriptionDate = Date(timeIntervalSince1970: expirationTimeInteval)
            isPremium = (Date().localDate() <= subscriptionDate)
            print("Settings load premium: \(isPremium)")
        }
    }
}
