//
//  PremiumView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 20.07.2022.
//

import SwiftUI
import StoreKit

struct PremiumView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        List {
            
            
            Section {
                PremiumItemView(name: "label_tip1".localized, about: "label_tip1detail".localized)
                PremiumItemView(name: "label_tip2".localized, about: "label_tip2detail".localized)
            } header: {
                Text("label_tips".localized)
            }
            
            Section {
                Text("label_premiumabout".localized)
                    .font(.system(size: 16))
            } header: {
                Text("label_aboutpremium".localized)
            }

            Section {
                if viewModel.isShopAvailable {
                    PremiumBannerView(isPremium: $viewModel.isPremium, premiumPrice: $viewModel.premiumPrice) {
                        viewModel.purshacePremium()
                    }
                } else {
                    Text("label_shopnotavailable".localized)
                        .foregroundColor(.gray)
                }
            } footer: {
                if viewModel.isShopAvailable {
                    Text("label_subscribe".localized)
                } else {
                    Text("")
                }
            }
        }
        .navigationTitle("title_premium".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PremiumItemView: View {
    let name: String
    let about: String
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .bold()
                    .font(.system(size: 16))
                Spacer()
            }
            HStack {
                Text(about)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Spacer()
            }
        }
    }
}