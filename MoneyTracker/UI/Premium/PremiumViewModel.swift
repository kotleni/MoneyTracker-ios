//
//  PremiumViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class PremiumViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    private let storageManager: StorageManager
    private let storeManager: StoreManager
    @Published private(set) var isShopAvailable: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var premiumPrice: String = ""
    
    init(storageManager: StorageManager, storeManager: StoreManager) {
        self.storageManager = storageManager
        self.storeManager = storeManager
    }
    
    /// Load all
    func loadData() {
        if let product = storeManager.products.first {
            premiumPrice = storeManager.priceFormatter(product)
            isShopAvailable = true
        }
    }
    
    /// Try purshace premium
    func purshacePremium() {
        storeManager.buyProductMonth { isSuccess in
            print(isSuccess)
        }
    }
}
