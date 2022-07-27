//
//  HomeViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    
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
        TagsPublisher(tagsManager: tagsManager)
            .sink { tags in
                self.tags = tags
                if self.tags.isEmpty {
                    self.addTag(name: "tag_food".localized, emoji: "🍗")
                    self.addTag(name: "tag_clothes".localized, emoji: "👚")
                    self.addTag(name: "tag_entertainment".localized, emoji: "🎭")
                    self.addTag(name: "tag_technique".localized, emoji: "💻")
                    self.addTag(name: "tag_any".localized, emoji: "📦")
                }
            }
            .store(in: &publishers)
        
        PaymentsPublisher(paymentsManager: paymentsManager)
            .sink { payments in
                self.payments = payments
                BalancePublisher(payments: payments)
                    .sink { balance in
                        self.balance = balance
                        self.isLoading = false
                    }
                    .store(in: &self.publishers)
            }
            .store(in: &publishers)
        
        self.priceType = self.storageManager.getPriceType()
    }
    
    /// Add new tag
    func addTag(name: String, emoji: String) {
        let tag = tagsManager.addTag(name: name, emoji: emoji)
        tags.append(tag)
    }
    
    /// Delete payment by index
    func deletePayment(index: Int) {
        self.paymentsManager.removePayment(index: index)
        self.payments.remove(at: index)
        self.isLoading = true
        BalancePublisher(payments: self.payments)
            .sink { balance in
                self.balance = balance
                self.isLoading = false
            }
            .store(in: &self.publishers)
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        let payment = self.paymentsManager.addPayment(price: price, about: about, tag: tag)
        self.payments.insert(payment, at: 0)
        self.isLoading = true
        BalancePublisher(payments: self.payments)
            .sink { balance in
                self.balance = balance
                self.isLoading = false
            }
            .store(in: &self.publishers)
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
}
