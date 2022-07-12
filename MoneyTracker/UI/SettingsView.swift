//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

fileprivate var eggsCounter: Int = 0

struct SettingsView: View {
    @State private var priceType: String = ""
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
                Text("Разработчик: \(developerString)")
                    .onTapGesture {
                        trackEggs()
                    }
                Text("Версия: \(versionString)")
                Button {
                    guard let url = URL(string: appstoreUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("Приложение в AppStore")
                }
                Button {
                    guard let url = URL(string: githubUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("Приложение на Github")
                }
            } header: {
                Text("О приложении")
            }

            if showEggs {
                Section {
                    Button {
                        StorageManager.shared.setPriceType(type: "")
                    } label: {
                        Text("Reset currency")
                    }
                    
                    Button {
                        for _ in 0...10 {
                            CoreDataManager.shared.addPayment(price: 256, about: "Added from dev menu")
                        }
                    } label: {
                        Text("Add 10 payments")
                    }

                } header: {
                    Text("Developer Menu")
                }

            }
        }
    }
    
    func trackEggs() {
        eggsCounter += 1
        if eggsCounter == 9 {
            showEggs = true
        }
    }
}
