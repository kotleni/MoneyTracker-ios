//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

@main
struct MoneyTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    private let storeManager: StoreManager
    private let keychainManager: KeychainManager
    
    private let managersContainer: ManagersContainer
    
    init() {
        // managers
        paymentsManager = PaymentsManager()
        storageManager = StorageManager()
        notificationsManager = NotificationsManager()
        tagsManager = TagsManager()
        keychainManager = KeychainManager()
        storeManager = StoreManager(keychain: keychainManager, productsIDs: Static.subscriptionsID)
        
        managersContainer = ManagersContainer(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        
        // injects
        storeManager.requestProducts()
        appDelegate.store = storeManager
        appDelegate.keychain = keychainManager
    }
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(managersContainer: managersContainer)
            .view()
        }
    }
}
