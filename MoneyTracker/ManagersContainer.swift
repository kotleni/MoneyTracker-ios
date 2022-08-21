//
//  ManagersContainer.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 21.08.2022.
//

import Foundation

final class ManagersContainer {
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    private let storeManager: StoreManager
    private let keychainManager: KeychainManager
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager, storeManager: StoreManager, keychainManager: KeychainManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        self.storeManager = storeManager
        self.keychainManager = keychainManager
    }
    
    func getPaymentsManager() -> PaymentsManager {
        return paymentsManager
    }
    
    func getStorageManager() -> StorageManager {
        return storageManager
    }
    
    func getNotificationsManager() -> NotificationsManager {
        return notificationsManager
    }
    
    func getTagsManager() -> TagsManager {
        return tagsManager
    }
    
    func getStoreManager() -> StoreManager {
        return storeManager
    }
    
    func getKeychainManager() -> KeychainManager {
        return keychainManager
    }
    
    static func getForPreview() -> ManagersContainer {
        return ManagersContainer(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), storeManager: StoreManager(keychain: KeychainManager(), productsIDs: Set<String>.init()), keychainManager: KeychainManager())
    }
}
