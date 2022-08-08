//
//  BaseViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import Foundation
import Combine

/// Universal view model base
class BaseViewModel: ObservableObject {
    internal let paymentsManager: PaymentsManager
    internal let storageManager: StorageManager
    internal let notificationsManager: NotificationsManager
    internal let tagsManager: TagsManager
    internal let storeManager: StoreManager
    internal let keychainManager: KeychainManager
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager, storeManager: StoreManager, keychainManager: KeychainManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        self.storeManager = storeManager
        self.keychainManager = keychainManager
    }
    
    /// All viewmodel publishers
    internal var publishers: Set<AnyCancellable> = []
    
    /// Loading data
    func loadData() { /* nothing */ }
}
