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
        didSet {
            storageManager.setExperimental(isEnable: isExperimental)
        }
    }
    
    /// Load all
    override func loadData() {
        isExperimental = storageManager.isExperimental()
    }
    
    /// Add random payment
    func addRandomPayment() {
        let _ = paymentsManager.addPayment(price: Float.random(in: -100...100), about: "Pizza 🍕")
    }
}
