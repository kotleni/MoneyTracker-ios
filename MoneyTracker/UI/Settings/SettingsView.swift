//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var isShowToast: Bool = false
    @State private var toastText: String = ""
    
    var body: some View {
        Form {
            Section {
                // notif
                SettingsItemView(title: "btn_notifchange".localized, action: {
                    if(viewModel.isPremium) {
                        router.route(to: \.notifications)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }, value: "")
                
                // currency
                SettingsItemView(title: "btn_currencychange".localized, action: {
                    router.route(to: \.currencyEditor)
                }, value: viewModel.currency)
                
                // tags
                SettingsItemView(title: "btn_edittags".localized, action: {
                    router.route(to: \.tagsEditor)
                }, value: "")
            } header: {
                Text("settings_main".localized)
            }

            Section {
                // premium
                SettingsItemView(title: "btn_premium".localized, action: {
                    router.route(to: \.premium)
                }, value: "")
                
                // developer
                if viewModel.isDeveloper {
                    SettingsItemView(title: "btn_devmenu".localized, action: {
                        router.route(to: \.developer)
                    }, value: "")
                }
                
                // reset payments
                SettingsItemView(title: "btn_resetpay".localized, action: {
                    if(viewModel.isPremium) {
                        router.route(to: \.resetPayments)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }, value: "")
                
                // about
                SettingsItemView(title: "btn_aboutapp".localized, action: {
                    router.route(to: \.aboutApp)
                }, value: "")
            } header: {
                Text("settings_other".localized)
            }
        }
        .background(Color("MainBackground"))
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_settings".localized)
        .onAppear { viewModel.loadData() }
    }
}

struct SettingsPreview: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), keychainManager: KeychainManager()))
    }
}
