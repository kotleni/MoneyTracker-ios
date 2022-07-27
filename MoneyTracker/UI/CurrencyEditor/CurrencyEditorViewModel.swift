//
//  CurrencyEditorViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 25.07.2022.
//

import SwiftUI

class CurrencyEditorViewModel: ObservableObject, BaseViewModel {
    private let storageManager: StorageManager
    
    @Published private(set) var selectedCurrencyId: UUID = Currencies.currenciesPopular.first!.id
    @Published private(set) var isLoading: Bool = true
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    /// Load data
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let priceType = self.storageManager.getPriceType()
            if let currency = Currency.findByCode(array: Currencies.currenciesAll, code: priceType) {
                self.selectedCurrencyId = currency.id
            } else { // is currency not found
                // reset it to default
                self.selectedCurrencyId = Currencies.currenciesPopular.first!.id
            }
            self.isLoading = false
        }
    }
    
    /// Set currency currency
    func setCurrency(id: UUID) {
        selectedCurrencyId = id
        if let currency = Currency.findById(array: Currencies.currenciesAll, id: selectedCurrencyId) {
            storageManager.setPriceType(type: currency.littleName)
        }
    }
}
