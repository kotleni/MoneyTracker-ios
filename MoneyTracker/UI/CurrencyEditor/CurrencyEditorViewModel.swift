//
//  CurrencyEditorViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 25.07.2022.
//

import SwiftUI
import Combine

class CurrencyEditorViewModel: BaseViewModel {
    @Published private(set) var selectedCurrencyId: UUID = Currencies.currenciesPopular.first!.id
    @Published private(set) var isLoading: Bool = true
    
    @Published private(set) var currenciesFiltered: Array<Currency> = []
    
    /// Load data
    override func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let priceType = self.storageManager.getPriceType()
            if let currency = Currency.findByCode(array: Currencies.currenciesAll, code: priceType) { // MARK: todo fix deprecation
                DispatchQueue.main.async {
                    self.selectedCurrencyId = currency.id
                }
            } else { // is currency not found
                // reset it to default
                DispatchQueue.main.async {
                self.selectedCurrencyId = Currencies.currenciesPopular.first!.id
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
                self.updateFilter(filterString: "")
            }
        }
    }
    
    /// Set currency currency
    func setCurrency(id: UUID) {
        selectedCurrencyId = id
        if let currency = Currency.findById(array: Currencies.currenciesAll, id: selectedCurrencyId) { // MARK: todo fix deprecation
            storageManager.setPriceType(type: currency.littleName)
        }
    }
    
    /// Update filtered currencies list
    func updateFilter(filterString: String) {
        if filterString == "" {
            // set to all
            self.currenciesFiltered = Currencies.currenciesAll
            return
        }
        
        // clean
        currenciesFiltered.removeAll()
        
        Task.init {
            Currencies.currenciesAll.forEach { currency in
                if currency.fullName.lowercased().contains(filterString.lowercased()) ||
                    currency.littleName.lowercased().contains(filterString.lowercased()) {
                    currenciesFiltered.append(currency)
                }
            }
        }
    }
}
