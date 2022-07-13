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
    @State private var isShowSheet: Bool = false
    
    // eggs vars
    @State private var showEggs: Bool = false
    @State private var showSuperEggs: Bool = false
    
    var body: some View {
        Form {
            Section {
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
                                        hour: 19,
                                        minute: 00
                                    )
                                }
                            }
                        } else {
                            NotificationsManager.shared.stop()
                        }
                    }
                
                // currency change btn
                Button {
                    isShowSheet = true
                } label: {
                    Text("btn_selectcurrency".localized)
                        .padding(.trailing, 2)
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
                Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
                
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
                    // add 10 paymebts btn
                    Button {
                        for _ in 0...10 {
                            CoreDataManager.shared.addPayment(price: 256, about: "Test")
                        }
                    } label: {
                        Text("Add 10 payments")
                    }
                } header: {
                    Text("Developer Menu")
                }

            }
        }
        .onAppear { loadAll() }
        .sheet(isPresented: $isShowSheet) {
            ChangeCurrencyView(isShowing: $isShowSheet)
        }
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

struct SettingsPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
