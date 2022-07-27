//
//  AddPaymentViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI

class AddPaymentViewModel: ObservableObject, BaseViewModel {
    private let paymentsManager: PaymentsManager
    private let tagsManager: TagsManager
    
    @Published private(set) var tags: [Tag] = []
    
    init(paymentsManager: PaymentsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.tagsManager = tagsManager
    }
    
    /// Load all
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.tags = self.tagsManager.getTags()
        }
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        let _ = paymentsManager.addPayment(price: price, about: about, tag: tag)
    }
}
