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
    
    // viewmodels
    private let homeViewModel: HomeViewModel
    private let settingsViewModel: SettingsViewModel
    
    init() {
        // managers
        paymentsManager = PaymentsManager()
        storageManager = StorageManager()
        notificationsManager = NotificationsManager()
        tagsManager = TagsManager()
        
        // viewmodels
        homeViewModel = HomeViewModel(paymentsManager: paymentsManager, storageManager: storageManager, tagsManager: tagsManager)
        homeViewModel.loadAll()
        settingsViewModel = SettingsViewModel(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager)
        settingsViewModel.loadAll()
    }
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(homeViewModel: homeViewModel, settingsViewModel: settingsViewModel)
                .view()
        }
    }
}
