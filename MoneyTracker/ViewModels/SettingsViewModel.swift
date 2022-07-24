//
//  SettingsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    
    @Published private(set) var isDeveloper: Bool = false
    @Published private(set) var isPremium: Bool = false
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
    }
    
    /// Load all
    func loadAll() {
        loadPremium()
        DispatchQueue.global(qos: .userInitiated).async {
            
        }
    }
    
    /// Load premium in background
    func loadPremium() {
        // MARK: todo
    }
}
