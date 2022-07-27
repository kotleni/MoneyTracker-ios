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
    
    @Published private(set) var balance: Balance
    @Published private(set) var priceType: String = "USD"
    @Published private(set) var payments: [Payment] = []
    @Published private(set) var selectedFilter: String = Filter.all.rawValue
    @Published private(set) var tags: [Tag] = []
    @Published private(set) var isLoading: Bool = true
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.tagsManager = tagsManager
        
        self.balance = Balance(current: 0, income: 0, outcome: 0)
    }
    
    /// Load data
    func loadData() {
        loadPremium()
        loadTags()
        DispatchQueue.global(qos: .userInitiated).async {
            let _tags = self.tagsManager.getTags()
            let _payments = self.paymentsManager.getPayments()
            let _priceType = self.storageManager.getPriceType()
            let _balance = self.calculateBalance()
            DispatchQueue.main.async {
                self.isLoading = false
                self.tags = _tags
                self.payments = _payments
                self.priceType = _priceType
                self.balance = _balance
            }
        }
    }
    
    /// Load premium in background
    func loadPremium() {
        // MARK: todo
    }
    
    /// Load tags
    func loadTags() {
        DispatchQueue.global().async {
            let _tags = self.tagsManager.getTags()
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
        let tag = tagsManager.addTag(name: name, emoji: emoji)
        tags.append(tag)
    }
    
    /// Delete payment by index
    func deletePayment(index: Int) {
        DispatchQueue.global().async {
            self.paymentsManager.removePayment(index: index)
            DispatchQueue.main.async {
                self.payments.remove(at: index)
                DispatchQueue.global(qos: .userInitiated).async {
                    let _balance = self.calculateBalance()
                    DispatchQueue.main.async {
                        self.balance = _balance
                    }
                }
            }
        }
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        DispatchQueue.global().async {
            let payment = self.paymentsManager.addPayment(price: price, about: about, tag: tag)
            DispatchQueue.main.async {
                self.payments.insert(payment, at: 0)
                DispatchQueue.global(qos: .userInitiated).async {
                    let _balance = self.calculateBalance()
                    DispatchQueue.main.async {
                        self.balance = _balance
                    }
                }
            }
        }
    }
    
    /// Find tag by name
    func findTagByName(name: String) -> Tag? {
        var result: Tag? = nil
        tags.forEach { tag in
            if tag.name == name {
                result = tag
            }
        }
        return result
    }
    
    /// Calculate payments
    private func calculateBalance() -> Balance {
        var _income: Float = 0
        var _outcome: Float = 0
        self.payments.forEach { payment in
            if payment.price > 0 { // is income
                _income += payment.price
            } else if payment.price < 0 { // is outcome
                _outcome += payment.price
            }
        }
        
        return Balance(current: _income + _outcome, income: _income, outcome: _outcome)
    }
}
