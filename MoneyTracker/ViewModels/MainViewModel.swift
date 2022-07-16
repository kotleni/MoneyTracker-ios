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
    
    /// Load all data in bg
    func loadAllData() {
        loadPremiumState()
        DispatchQueue.global().async {
            let _payments = CoreDataManager.shared.getPayments()
            let _priceType = StorageManager.shared.getPriceType()
            DispatchQueue.main.async {
                self.isLoading = false
                
                self.payments = _payments
                self.priceType = _priceType
                self.calculatePayments()
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
            CoreDataManager.shared.removePayment(index: index)
            DispatchQueue.main.async {
                self.payments.remove(at: index)
            }
        }
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag = Tag.other) {
        DispatchQueue.global().async {
            let payment = CoreDataManager.shared.addPayment(price: price, about: about, tag: tag)
            DispatchQueue.main.async {
                self.payments.insert(payment, at: 0)
            }
        }
    }
    
    /// Remove all payments
    func removeAllPayments() {
        CoreDataManager.shared.removeAll()
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
}
