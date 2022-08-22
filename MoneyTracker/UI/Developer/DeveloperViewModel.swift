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
    
    /// Load all
    override func loadData() {
        isExperimental = storageManager.isExperimental()
    }
    
    /// Add special payments
    func addSpecialPayments() {
        let tags = tagsManager.getTags()
        
        _ = paymentsManager.addPayment(price: 4000, about: "Зарплата")
        _ = paymentsManager.addPayment(price: 160, about: "Отдали долг")
        _ = paymentsManager.addPayment(price: -307, about: "Купил пицу", tag: tags.first!)
    }
    
    /// Remove all payments
    func removeAllPayments() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.paymentsManager.removeAll()
        }
    }
}
