//
//  DeveloperViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class DeveloperViewModel: BaseViewModel {
    @Published var isExperimental: Bool = false {
        didSet { storageManager.setExperimental(isEnable: isExperimental) }
    }
    
    @Published var isNotifEnable: Bool = false {
        didSet { storageManager.setNotifEnable(isEnable: isNotifEnable) }
    }
    
    @Published var isDeveloper: Bool = false {
        didSet { storageManager.setDeveloper(isEnable: isDeveloper) }
    }
    
    /// Load all
    override func loadData() {
        isExperimental = storageManager.isExperimental()
        isNotifEnable = storageManager.isNotifEnable()
        isDeveloper = storageManager.isDeveloper()
    }
    
    /// Add special payments
    func addSpecialPayments() {
        let tags = tagsManager.getTags()
        
        let _ = paymentsManager.addPayment(price: 4000, about: "Зарплата")
        let _ = paymentsManager.addPayment(price: 160, about: "Отдали долг")
        let _ = paymentsManager.addPayment(price: -307, about: "Купил пицу", tag: tags.first!)
    }
    
    /// Remove all payments
    func removeAllPayments() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.paymentsManager.removeAll()
        }
    }
    
    /// Remove all tags
    func removeAllTags() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.tagsManager.getTags().forEach { tag in
                self.tagsManager.removeTag(tag: tag)
            }
        }
    }
}
