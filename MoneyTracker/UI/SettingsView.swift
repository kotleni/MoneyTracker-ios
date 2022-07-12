//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

fileprivate var eggsCounter: Int = 0

struct SettingsView: View {
    @State private var priceType: String = "Undefined"
    @State private var showEggs: Bool = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Валюта: ")
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
                }

                
                Button {
                    CoreDataManager.shared.removeAll()
                    exit(0)
                } label: {
                    Text("Сбросить платежи")
                        .foregroundColor(.red)
                }
            } header: {
                Text("Конфигурация")
            }
            
            Section {
                Text("Разработчик: Victor Varenik")
                    .onTapGesture {
                        trackEggs()
                    }
                Text("Версия: 2.0")
                Button {
                    guard let url = URL(string: "https://apps.apple.com/ua/app/moneytracker/id1631794003") else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("Приложение в AppStore")
                }
                Button {
                    guard let url = URL(string: "https://github.com/kotleni/MoneyTracker-ios/") else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("Приложение на Github")
                }
            } header: {
                Text("О приложении")
            }

        }
        .alert(isPresented: $showEggs) {
            Alert(title: Text("Welcome to funny-eggs alert!"), message: nil, dismissButton: .none)
        }
    }
    
    func trackEggs() {
        eggsCounter += 1
        if eggsCounter > 9 {
            showEggs = true
        }
    }
}
