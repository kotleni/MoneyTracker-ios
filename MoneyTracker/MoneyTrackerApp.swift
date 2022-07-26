//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

@main
struct MoneyTrackerApp: App {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    
    init() {
        // managers
        paymentsManager = PaymentsManager()
        storageManager = StorageManager()
        notificationsManager = NotificationsManager()
        tagsManager = TagsManager()
    }
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager)
                .view()
        }
    }
}
