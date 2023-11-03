//
//  CurrencyEditorViewModel.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 25.07.2022.
//

import SwiftUI
import Combine

class CurrencyEditorViewModel: BaseViewModel {
    @Published private(set) var selectedCurrencyId: UUID
        = Currencies.currenciesPopular.first!.id // force unwrap allowed, because it constant
    @Published private(set) var isLoading: Bool = true
    
    @Published private(set) var currenciesFiltered: [Currency] = []
    
    /// Load data
    override func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let priceType = self.storageManager.getPriceType()
            do {
                let currency = try Currency.findByCode(array: Currencies.currenciesAll, code: priceType)
                DispatchQueue.main.async { self.selectedCurrencyId = currency.id }
            } catch { // is error
                // reset it to default
                DispatchQueue.main.async {
                    // force unwrap allowed, because it constant
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
        do {
            let currency = try Currency.findById(array: Currencies.currenciesAll, id: selectedCurrencyId)
            storageManager.setPriceType(type: currency.littleName)
        } catch { }
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
