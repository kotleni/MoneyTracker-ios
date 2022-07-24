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
                SettingsItemView(title: "btn_notifchange".localized) {
                    if(viewModel.isPremium) {
                        router.route(to: \.notifications)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }
                
                // currency
                SettingsItemView(title: "btn_currencychange".localized) {
                    router.route(to: \.currencyEditor)
                }
                
                // tags
                SettingsItemView(title: "btn_edittags".localized) {
                    router.route(to: \.tagsEditor)
                }
                
                // about
                SettingsItemView(title: "btn_premium".localized) {
                    router.route(to: \.premium)
                }
                
                // developer
                if viewModel.isDeveloper {
                    SettingsItemView(title: "btn_devmenu".localized) {
                        router.route(to: \.developer)
                    }
                }
                
                // about
                SettingsItemView(title: "btn_aboutapp".localized) {
                    router.route(to: \.aboutApp)
                }
                
                // reset payments
                SettingsItemView(title: "btn_resetpay".localized) {
                    if(viewModel.isPremium) {
                        router.route(to: \.resetPayments)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }
            }
        }
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_settings".localized)
    }
}
