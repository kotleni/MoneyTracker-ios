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
    
    @Published private(set) var isShopAvailable: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var premiumPrice: String = ""
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    /// Load all
    func loadData() {
        
    }
    
    /// Try purshace premium
    func purshacePremium() {
        
    }
}
