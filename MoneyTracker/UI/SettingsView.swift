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
    @State private var showSuperEggs: Bool = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("label_currency".localized)
                        .padding(.trailing, 2)
                    Picker("label_currency".localized, selection: $priceType) {
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
                    Text("btn_resetpayments".localized)
                        .foregroundColor(.red)
                }
            } header: {
                Text("label_ordinary".localized)
            }
            
            Section {
                Text("label_developer".localized + "\(developerString)")
                    .onTapGesture {
                        trackEggs()
                    }
                Text("label_version".localized + "\(versionString)")
                Button {
                    guard let url = URL(string: appstoreUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appinappstore".localized)
                }
                Button {
                    guard let url = URL(string: githubUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appingithub".localized)
                }
            } header: {
                Text("label_aboutapp".localized)
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

                    if showSuperEggs {
                        Text("Україна переможе! 🇺🇦")
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
            HapticManager.shared.success()
        }
        if eggsCounter == 21 {
            showSuperEggs = true
            HapticManager.shared.success()
        }
    }
}
