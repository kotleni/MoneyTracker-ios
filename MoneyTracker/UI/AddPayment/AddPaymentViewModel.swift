//
//  AddPaymentViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class AddPaymentViewModel: BaseViewModel {
    @Published private(set) var tags: [Tag] = []
    
    /// Load all
    override func loadData() {
        TagsPublisher(tagsManager: tagsManager)
            .sink { tags in
                self.tags = tags
            }
            .store(in: &publishers)
    }
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag) {
        let _ = paymentsManager.addPayment(price: price, about: about, tag: tag)
    }
    
    /// Try add new payment
    func tryAddPayment(priceText: String, aboutText: String, spendingBool: Bool, selectedTag: Tag) {
        let priceStr = priceText.replacingOccurrences(of: ",", with: ".")
        let sum = MathematicalExpression(line: priceStr).calculate()
        guard let fl = Float(spendingBool ? "-\(sum)" : "\(sum)") else { return }
        let about = aboutText
        let tag = selectedTag
        
        addPayment(price: fl, about: about, tag: tag)
    }
}
