//
//  AddPaymentViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class AddPaymentViewModel: BaseViewModel {
    @Published var isError: Bool = false
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
    func tryAddPayment(priceText: String, aboutText: String, spendingBool: Bool, selectedTag: Tag, onFinish: (_ isSuccess: Bool) -> ()) {
        let priceStr = priceText.replacingOccurrences(of: ",", with: ".")
        let mathExp = MathematicalExpression(line: priceStr)
        do {
            let sum = try mathExp.calculate()
            guard let fl = Float(spendingBool ? "-\(sum)" : "\(sum)") else { return }
            let about = aboutText
            let tag = selectedTag
            
            addPayment(price: fl, about: about, tag: tag)
            
            onFinish(true)
        } catch let error {
            print(error)
            
            onFinish(false)
        }
    }
    
    /// Show error
    func showError() {
        isError = true
    }
}
