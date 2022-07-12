//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

// eggs counter
fileprivate var eggsCounter: Int = 0

struct SettingsView: View {
    @State private var priceType: String = ""
    @State private var isNotifOn: Bool = false
    
    // eggs vars
    @State private var showEggs: Bool = false
    @State private var showSuperEggs: Bool = false
    
    var body: some View {
        Form {
            Section {
                // currency picker
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
                
                // notifications toggle
                Toggle("label_notifications".localized, isOn: $isNotifOn)
                    .onChange(of: isNotifOn) { value in
                        // update notif pref
                        StorageManager.shared.setNotifEnable(isEnable: isNotifOn)
                        
                        if isNotifOn {
                            let center  = UNUserNotificationCenter.current()

                            center.requestAuthorization(options: [.alert, .badge]) { (granted, error) in
                                if error == nil {
                                    NotificationsManager.shared.start(
                                        title: "notif_title".localized,
                                        body: "notif_body".localized,
                                        hour: 22,
                                        minute: 46
                                    )
                                }
                            }
                        } else {
                            NotificationsManager.shared.stop()
                        }
                    }
                
                // reset paymetns btn
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
                // developer text
                Text("label_developer".localized + "\(developerString)")
                    .onTapGesture {
                        trackEggs()
                    }
                
                // version text
                Text("label_version".localized + "\(versionString)")
                
                // appstore btn
                Button {
                    guard let url = URL(string: appstoreUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appinappstore".localized)
                }
                
                // github btn
                Button {
                    guard let url = URL(string: githubUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appingithub".localized)
                }
            } header: {
                Text("label_aboutapp".localized)
            }

            // if eggs activate
            if showEggs {
                Section {
                    // reset currency btn
                    Button {
                        StorageManager.shared.setPriceType(type: "USD")
                    } label: {
                        Text("Reset currency")
                    }
                    
                    // add 10 paymebts btn
                    Button {
                        for _ in 0...10 {
                            CoreDataManager.shared.addPayment(price: 256, about: "Added from dev menu")
                        }
                    } label: {
                        Text("Add 10 payments")
                    }

                    // if super eggs activate
                    if showSuperEggs {
                        // ukraine ping text
                        Text("Україна переможе! 🇺🇦")
                    }
                } header: {
                    Text("Developer Menu")
                }

            }
        }
        .onAppear { loadAll() }
    }
    
    // load all values
    func loadAll() {
        isNotifOn = StorageManager.shared.isNotifEnable()
    }
    
    // track current state of eggs
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
