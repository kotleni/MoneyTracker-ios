//
//  ResetPaymentsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class ResetPaymentsViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    private let paymentsManager: PaymentsManager
    
    init(paymentsManager: PaymentsManager) {
        self.paymentsManager = paymentsManager
    }
    
    /// Load all
    func loadData() {
        
    }
    
    /// Remove all payments
    func removeAllPayments() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.paymentsManager.removeAll()
        }
    }
}
