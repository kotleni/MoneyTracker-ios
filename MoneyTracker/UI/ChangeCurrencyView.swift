//
//  ChangeCurrencyView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct ChangeCurrencyView: View {
    @State private var filterText: String = ""
    @State private var selectedCurrencyId: UUID = currenciesPopular.first!.id
    
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $filterText, hint: "hint_search".localized)
                
                List {
                    // popular
                    Section {
                        ForEach(currenciesPopular, id: \.self) { curr in
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
                                }
                            }
                        }
                    } header: {
                        Text("label_popular".localized)
                    }

                    // all
                    Section {
                        ForEach(currenciesAll, id: \.self) { curr in
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowing = false
                    } label: {
                        Text("btn_cancel".localized)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        DispatchQueue.global().async {
                            let currency = Currency.findById(array: currenciesAll, id: selectedCurrencyId)!
                            StorageManager.shared.setPriceType(type: currency.littleName)
                            isShowing = false
                        }
                    } label: {
                        Text("btn_next".localized)
                    }
                }
            }
        }
    }
    
    private func loadStorage() {
        let priceType = StorageManager.shared.getPriceType()
        let currency = Currency.findByCode(array: currenciesAll, code: priceType)
        selectedCurrencyId = currency!.id
    }
}

