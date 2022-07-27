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
            let _tags = self.tagsManager.getTags()
            DispatchQueue.main.async {
                self.tags = _tags
            }
        }
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        let _ = paymentsManager.addPayment(price: price, about: about, tag: tag)
    }
    
    /// Try add new payment
    func tryAddPayment(priceText: String, aboutText: String, spendingBool: Bool, selectedTag: Tag) {
        let priceStr = priceText.replacingOccurrences(of: ",", with: ".")
        let sum = MathematicalExpression(line: priceStr).makeResult()
        guard let fl = Float(spendingBool ? "-\(sum)" : "\(sum)") else { return }
        let about = aboutText
        let tag = selectedTag
        
        addPayment(price: fl, about: about, tag: tag)
    }
}
