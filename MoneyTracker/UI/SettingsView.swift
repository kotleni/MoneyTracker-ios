//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var priceType: String = "Undefined"
    
    var body: some View {
        Form {
            Section {
                Picker("Currency", selection: $priceType) {
                    ForEach(currencyList, id: \.self) { type in
                        Text(type)
                    }
                }
                .onAppear {
                    priceType = StorageManager.shared.getPriceType()
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: priceType, perform: { value in
                    StorageManager.shared.setPriceType(type: priceType)
                })
            } header: {
                Text("Выберите вашу валюту")
            }

        }
    }
}
