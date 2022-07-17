//
//  MainViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var payments: [Payment] = []
    @Published var priceType: String = "USD"
    @Published var totalBalance: Float = 0
    @Published var selectedFilter: String = Filter.all.rawValue
    @Published var isNotifOn: Bool = false
    @Published var isDeveloperOn: Bool = false
    @Published var isPremium: Bool = false
    @Published var premiumPrice: String = ""
    @Published var tags: [Tag] = []
    
    /// Load all data in bg
    func loadAllData() {
        loadTags()
        
        loadPremiumState()
        DispatchQueue.global().async {
            let _payments = PaymentsManager.shared.getPayments()
            let _priceType = StorageManager.shared.getPriceType()
            
            print("Payments loaded: \(_payments.count)")
            DispatchQueue.main.async {
                self.isLoading = false
                
                self.payments = _payments
                self.priceType = _priceType
                self.calculatePayments()
            }
        }
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
    
    /// Load premium state in bg
    func loadPremiumState() {
        Task.init {
            let isPremium = await PremiumManager.shared.isPremiumExist()
            let premiumPrice = await PremiumManager.shared.getPremiumPrice()
            
            DispatchQueue.main.async {
                self.isPremium = isPremium
                self.premiumPrice = premiumPrice
            }
            
            if !isPremium && isNotifOn {
                StorageManager.shared.setNotifEnable(isEnable: false)
                isNotifOn = false
            }
        }
    }
    
    /// Calcucate payments in bg
    func calculatePayments() {
        DispatchQueue.global().async {
            var value: Float = 0.0
            self.payments.forEach { payment in
                value += payment.price
            }
            DispatchQueue.main.async {
                self.totalBalance = value
            }
        }
    }
    
    /// Delete payment by index
    func deletePayment(index: Int) {
        DispatchQueue.global().async {
            PaymentsManager.shared.removePayment(index: index)
            DispatchQueue.main.async {
                self.payments.remove(at: index)
                self.calculatePayments()
            }
        }
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag = Tag.getDefault()) {
        DispatchQueue.global().async {
            let payment = PaymentsManager.shared.addPayment(price: price, about: about, tag: tag)
            DispatchQueue.main.async {
                self.payments.insert(payment, at: 0)
                self.calculatePayments()
            }
        }
    }
    
    /// Remove all payments
    func removeAllPayments() {
        payments = []
        totalBalance = 0
        PaymentsManager.shared.removeAll()
    }
    
    /// Try purshace premium
    func purshacePremium() {
        Task.init {
            let _ = await PremiumManager.shared.trySubscribe()
            isPremium = await PremiumManager.shared.isPremiumExist()
        }
    }
    
    /// Update notifications state
    func setNotifications(state: Bool) {
        StorageManager.shared.setNotifEnable(isEnable: state)
    }
    
    /// Update currency
    func setCurrency(currency: Currency) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.priceType = currency.littleName
            }
            StorageManager.shared.setPriceType(type: currency.littleName)
        }
    }
    
    /// Add new tag
    func addTag(name: String, emoji: String) {
        let tag = TagsManager.shared.addTag(name: name, emoji: emoji)
        tags.append(tag)
    }
    
    /// Remove tag by index
    func removeTag(index: Int) {
        TagsManager.shared.removeTag(tag: tags[index])
        tags.remove(at: index)
    }
    
    /// Remove all tags and set default
    func resetTags() {
        tags.forEach { _ in
            removeTag(index: 0)
        }
        loadTags()
    }
}
