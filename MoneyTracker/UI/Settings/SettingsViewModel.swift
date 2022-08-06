//
//  SettingsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    private let keychainManager: KeychainManager
    
    @Published private(set) var isDeveloper: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var currency: String = ""
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager, keychainManager: KeychainManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        self.keychainManager = keychainManager
    }
    
    /// Load data
    func loadData() {
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
