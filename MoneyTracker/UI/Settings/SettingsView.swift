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
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowPremiumWarn: Bool = false
    
    var body: some View {
        Form {
            Section {
                if viewModel.isPremium {
                    Text("label_premiumactive".localized)
                } else if viewModel.premiumPrice.isEmpty {
                    ProgressView()
                } else {
                    Button(action: {
                        viewModel.purshacePremium()
                    }, label: {
                        VStack {
                            HStack {
                                Text("label_premiumsubscribe".localized)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                            HStack {
                                Text("label_premiumaboutleft".localized + viewModel.premiumPrice + "label_premiumaboutright".localized)
                                    .opacity(0.7)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                        }
                    })
                }
                
            } header: {
                Text("label_subscribe".localized)
            }
            
            Section {
                // notifications toggle
                Toggle("label_notifications".localized, isOn: $viewModel.isNotifOn)
                    .onChange(of: viewModel.isNotifOn) { value in
                        if(!viewModel.isPremium) {
                            isShowPremiumWarn = true
                            DispatchQueue.global().async {
                                sleep(1)
                                viewModel.isNotifOn = false
                            }
                            return
                        }
                        
                        viewModel.setNotifications(state: viewModel.isNotifOn)
                        
                        if viewModel.isNotifOn {
                            let center  = UNUserNotificationCenter.current()

                            center.requestAuthorization(options: [.alert, .badge]) { (granted, error) in
                                if error == nil {
                                    NotificationsManager.shared.stop()
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
                
                NavigationLink {
                    ChangeCurrencyView(viewModel: viewModel)
                } label: {
                    Text("btn_selectcurrency".localized)
                        .padding(.trailing, 2)
                }

                
                // reset paymetns btn
                Button {
                    viewModel.removeAllPayments()
                    exit(0)
                } label: {
                    Text("btn_resetpayments".localized)
                        .foregroundColor(.red)
                }
                
                // if developer mode activate
                if viewModel.isDeveloperOn {
                    NavigationLink {
                        DevMenuView(viewModel: viewModel)
                    } label: {
                        Text("Developer Menu")
                    }

                }
            } header: {
                Text("label_ordinary".localized)
            }
            
            Section {
                // developer text
                Text("label_developer".localized + "\(Static.developerString)")
                    .onTapGesture {
                        trackEggs()
                    }
                
                // version text
                Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
                
                // appstore btn
                Button {
                    guard let url = URL(string: Static.appstoreUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appinappstore".localized)
                }
                
                // github btn
                Button {
                    guard let url = URL(string: Static.githubUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_appingithub".localized)
                }
            } header: {
                Text("label_aboutapp".localized)
            }
        }
        .alert("premium_warn".localized, isPresented: $isShowPremiumWarn) {
            Button("OK") {
                isShowPremiumWarn = false
            }
        }
    }
    
    // track current state of eggs
    func trackEggs() {
        eggsCounter += 1
        if eggsCounter == 4 {
            viewModel.isDeveloperOn = true
            HapticManager.shared.success()
        }
    }
}


