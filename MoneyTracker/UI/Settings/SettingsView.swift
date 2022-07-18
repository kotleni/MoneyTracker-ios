//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isShowToast: Bool = false
    @State private var toastText: String = ""
    
    var body: some View {
        Form {
            if viewModel.isShopAvailable {
                Section {
                    PremiumBannerView(isPremium: $viewModel.isPremium, premiumPrice: $viewModel.premiumPrice) {
                        viewModel.purshacePremium()
                    }
                } header: {
                    Text("label_subscribe".localized)
                }
            }
            
            Section {
                // notif
                SettingsItemView(title: "btn_notifchange".localized, imageName: "bell.fill", imageColor: .blue) {
                    if(viewModel.isPremium) {
                        router.route(to: \.notifications)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }
                
                // currency
                SettingsItemView(title: "btn_currencychange".localized, imageName: "dollarsign.circle.fill", imageColor: .green) {
                    router.route(to: \.currencyEditor)
                }
                
                // tags
                SettingsItemView(title: "btn_edittags".localized, imageName: "tag.fill", imageColor: .red) {
                    router.route(to: \.tagsEditor)
                }
                
                // developer
                if viewModel.isDeveloperOn {
                    SettingsItemView(title: "btn_devmenu".localized, imageName: "hammer.fill", imageColor: .blue) {
                        router.route(to: \.developer)
                    }
                }
                
                // about
                SettingsItemView(title: "btn_aboutapp".localized, imageName: "info.circle.fill", imageColor: .indigo) {
                    router.route(to: \.aboutApp)
                }
                
                // reset payments
                SettingsItemView(title: "btn_resetpay".localized, imageName: "trash.fill", imageColor: .orange) {
                    router.route(to: \.resetPayments)
                }
            }
        }
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_settings".localized)
    }
}
