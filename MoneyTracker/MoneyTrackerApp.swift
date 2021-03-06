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
    init() {
        // managers
        paymentsManager = PaymentsManager()
        storageManager = StorageManager()
        notificationsManager = NotificationsManager()
        tagsManager = TagsManager()
        storeManager = StoreManager(productsIDs: Static.subscriptionsID)
        // injects
        storeManager.requestProducts()
        appDelegate.store = storeManager
    }
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager)
                .view()
        }
    }
}
