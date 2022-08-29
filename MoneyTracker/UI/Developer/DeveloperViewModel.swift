//
//  DeveloperViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class DeveloperViewModel: BaseViewModel {
    /// Load all
    override func loadData() {
    }
    
    /// Add special payments
    func addSpecialPayments() {
        _ = paymentsManager.addPayment(price: 4000, about: "Зарплата")
        _ = paymentsManager.addPayment(price: 160, about: "Отдали долг")
        _ = paymentsManager.addPayment(price: -307, about: "Купил пицу", tag: tagsManager.getDefaultTag())
    }
    
    /// Remove all payments
    func removeAllPayments() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.paymentsManager.removeAll()
        }
    }
}
