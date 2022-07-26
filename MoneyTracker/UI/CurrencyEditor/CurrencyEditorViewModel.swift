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
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    /// Load data
    func loadData() {
        let priceType = storageManager.getPriceType()
        let currency = Currency.findByCode(array: Currencies.currenciesAll, code: priceType)
        selectedCurrencyId = currency!.id
    }
    
    /// Set currency currency
    func setCurrency(id: UUID) {
        selectedCurrencyId = id
        let currency = Currency.findById(array: Currencies.currenciesAll, id: selectedCurrencyId)!
        storageManager.setPriceType(type: currency.littleName)
    }
}
