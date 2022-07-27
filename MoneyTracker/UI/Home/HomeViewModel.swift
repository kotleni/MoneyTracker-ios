//
//  HomeViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject, BaseViewModel {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let tagsManager: TagsManager
    
    @Published private(set) var totalBalance: Float = 0
    @Published private(set) var totalIncome: Float = 0
    @Published private(set) var totalOutcome: Float = 0
    @Published private(set) var priceType: String = "USD"
    @Published private(set) var payments: [Payment] = []
    @Published private(set) var selectedFilter: String = Filter.all.rawValue
    @Published private(set) var tags: [Tag] = []
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.tagsManager = tagsManager
    }
    
    /// Load data
    func loadData() {
        loadPremium()
        loadTags()
        DispatchQueue.global(qos: .userInitiated).async {
            self.tags = self.tagsManager.getTags()
            self.payments = self.paymentsManager.getPayments()
            self.priceType = self.storageManager.getPriceType()
            self.calculatePayments()
        }
    }
    
    /// Load premium in background
    func loadPremium() {
        // MARK: todo
    }
    
    /// Load tags
    func loadTags() {
        DispatchQueue.global().async {
            let _tags = TagsManager.shared.getTags()
            DispatchQueue.main.async {
                self.tags = _tags
                
                // first setup for tags
                // is tags not exist
                if self.tags.isEmpty {
                    self.addTag(name: "tag_food".localized, emoji: "🍗")
                    self.addTag(name: "tag_clothes".localized, emoji: "👚")
                    self.addTag(name: "tag_entertainment".localized, emoji: "🎭")
                    self.addTag(name: "tag_technique".localized, emoji: "💻")
                    self.addTag(name: "tag_any".localized, emoji: "📦")
                }
            }
        }
    }
    
    /// Add new tag
    func addTag(name: String, emoji: String) {
        let tag = TagsManager.shared.addTag(name: name, emoji: emoji)
        tags.append(tag)
    }
    
    /// Delete payment by index
    func deletePayment(index: Int) {
        DispatchQueue.global().async {
            self.paymentsManager.removePayment(index: index)
            DispatchQueue.main.async {
                self.payments.remove(at: index)
                self.calculatePayments()
            }
        }
    }
    
    // Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        DispatchQueue.global().async {
            let payment = self.paymentsManager.addPayment(price: price, about: about, tag: tag)
            DispatchQueue.main.async {
                self.payments.insert(payment, at: 0)
                self.calculatePayments()
            }
        }
    }
    
    /// Calculate payments
    private func calculatePayments() {
        var _income: Float = 0
        var _outcome: Float = 0
        self.payments.forEach { payment in
            if payment.price > 0 { // is income
                _income += payment.price
            } else if payment.price < 0 { // is outcome
                _outcome += payment.price
            }
        }
        
        self.totalBalance = _income + _outcome
        self.totalIncome = _income
        self.totalOutcome = _outcome
    }
}
