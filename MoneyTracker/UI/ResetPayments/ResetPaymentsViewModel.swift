//
//  ResetPaymentsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class ResetPaymentsViewModel: BaseViewModel {
    /// Load data
    override func loadData() {
        
    }
    
    /// Remove all payments
    func removeAllPayments() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.paymentsManager.removeAll()
        }
    }
}
