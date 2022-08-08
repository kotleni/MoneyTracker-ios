//
//  DeveloperViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class DeveloperViewModel: BaseViewModel, ObservableObject {
    private let storageManager: StorageManager
    private let tagsManager: TagsManager
    private let paymentsManager: PaymentsManager
    private let notificationsManager: NotificationsManager
    
    @Published var isExperimental: Bool = false {
        didSet {
            storageManager.setExperimental(isEnable: isExperimental)
        }
    }
    
    init(storageManager: StorageManager, tagsManager: TagsManager, paymentsManager: PaymentsManager, notificationsManager: NotificationsManager) {
        self.storageManager = storageManager
        self.tagsManager = tagsManager
        self.paymentsManager = paymentsManager
        self.notificationsManager = notificationsManager
    }
    
    /// Load all
    override func loadData() {
        isExperimental = storageManager.isExperimental()
    }
    
    /// Add random payment
    func addRandomPayment() {
        let _ = paymentsManager.addPayment(price: Float.random(in: -100...100), about: "Pizza 🍕")
    }
}
