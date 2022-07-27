//
//  PremiumViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI

class PremiumViewModel: ObservableObject, BaseViewModel {
    private let storageManager: StorageManager
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    /// Load all
    func loadData() {
        
    }
}
