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
    
    @Published private(set) var isDeveloper: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var currency: String = ""
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
    }
    
    /// Load data
    func loadData() {
        currency = storageManager.getPriceType()
        isDeveloper = storageManager.isDeveloper()
    }
}
