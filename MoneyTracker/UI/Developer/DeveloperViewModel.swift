//
//  DeveloperViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI

class DeveloperViewModel: ObservableObject, BaseViewModel {
    private let storageManager: StorageManager
    private let tagsManager: TagsManager
    private let paymentsManager: PaymentsManager
    private let notificationsManager: NotificationsManager
    
    init(storageManager: StorageManager, tagsManager: TagsManager, paymentsManager: PaymentsManager, notificationsManager: NotificationsManager) {
        self.storageManager = storageManager
        self.tagsManager = tagsManager
        self.paymentsManager = paymentsManager
        self.notificationsManager = notificationsManager
    }
    
    /// Load all
    func loadData() {
        
    }
}
