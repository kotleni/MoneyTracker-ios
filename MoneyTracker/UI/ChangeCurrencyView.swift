//
//  ChangeCurrencyView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct ChangeCurrencyView: View {
    @State private var filterText: String = ""
    @State private var selectedCurrencyId: UUID = Currencies.currenciesPopular.first!.id
    
    var body: some View {
        VStack {
            SearchBarView(text: $filterText, hint: "hint_search".localized)
            
            List {
                // popular
                Section {
                    ForEach(Currencies.currenciesPopular, id: \.self) { curr in
                        if curr.fullName.lowercased().contains(filterText.lowercased()) || curr.littleName.lowercased().contains(filterText.lowercased()) || filterText.isEmpty {
                            HStack {
                                Text(curr.fullName)
                                Text(curr.littleName)
                                    .foregroundColor(.gray)
                                Spacer()
                                if (selectedCurrencyId == curr.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .transition(.opacity)
                                }
                            }
                            .onTapGesture {
                                selectedCurrencyId = curr.id
                                updateCurrency()
                            }
                        }
                    }
                } header: {
                    Text("label_popular".localized)
                }

                // all
                Section {
                    ForEach(Currencies.currenciesAll, id: \.self) { curr in
                        if curr.fullName.lowercased().contains(filterText.lowercased()) || curr.littleName.lowercased().contains(filterText.lowercased()) || filterText.isEmpty {
                            HStack {
                                Text(curr.fullName)
                                Text(curr.littleName)
                                    .foregroundColor(.gray)
                                Spacer()
                                if (selectedCurrencyId == curr.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .transition(.opacity)
                                }
                            }
                            .onTapGesture {
                                selectedCurrencyId = curr.id
                                updateCurrency()
                            }
                        }
                    }
                } header: {
                    Text("Все")
                }
            }
            
            Spacer()
        }
        .onAppear { loadStorage() }
        .navigationBarTitle("label_selectpricetype".localized, displayMode: .inline)
    }
    
    private func updateCurrency() {
        DispatchQueue.global().async {
            let currency = Currency.findById(array: Currencies.currenciesAll, id: selectedCurrencyId)!
            StorageManager.shared.setPriceType(type: currency.littleName)
        }
    }
    
    /// load current currency from storage
    private func loadStorage() {
        let priceType = StorageManager.shared.getPriceType()
        let currency = Currency.findByCode(array: Currencies.currenciesAll, code: priceType)
        selectedCurrencyId = currency!.id
    }
}

