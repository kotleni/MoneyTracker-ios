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
    let paymentsManager: PaymentsManager
    let storageManager: StorageManager
    let notificationsManager: NotificationsManager
    let tagsManager: TagsManager
    let storeManager: StoreManager
    let keychainManager: KeychainManager
    
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
    var publishers: Set<AnyCancellable> = []
    
    /// Loading data
    func loadData() { }
}
