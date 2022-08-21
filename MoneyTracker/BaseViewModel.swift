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
    // managers
    internal let paymentsManager: PaymentsManager
    internal let storageManager: StorageManager
    internal let notificationsManager: NotificationsManager
    internal let tagsManager: TagsManager
    internal let storeManager: StoreManager
    internal let keychainManager: KeychainManager
    
    init(
        managersContainer: ManagersContainer
    ) {
        self.paymentsManager = managersContainer.getPaymentsManager()
        self.storageManager = managersContainer.getStorageManager()
        self.notificationsManager = managersContainer.getNotificationsManager()
        self.tagsManager = managersContainer.getTagsManager()
        self.storeManager = managersContainer.getStoreManager()
        self.keychainManager = managersContainer.getKeychainManager()
    }
    
    /// All viewmodel publishers
    internal var publishers: Set<AnyCancellable> = []
    
    /// Loading data
    func loadData() { /* nothing */ }
}
