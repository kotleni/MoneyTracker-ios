//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import UIKit
import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: DeveloperViewModel
    
    @State private var isPremium: Bool = false
    
    var body: some View {
        Form {
            Section {
                Button {
                    viewModel.addRandomPayment()
                } label: {
                    Text("Add payment")
                }
            } header: {
                Text("Debug")
            }
            
            Section {
                HomeBalanceView(totalBalance: 0, priceType: "USD", action: {})
                HomeBalance2View(totalIncome: 0, totalOutcome: 0, priceType: "USD")
                PremiumBannerView(isPremium: isPremium, premiumPrice: "0.0 USD", action: { isPremium.toggle() })
                SettingsItemView(title: "Title", action: {}, value: "Value")
                SearchBarView(text: .constant(""), hint: "Search")
                EmojiTextField(text: .constant(""), placeholder: "Emoji")
                PizzaChart(radius: 24, items: [
                    ChartItem(name: "First", value: 17, color: .red),
                    ChartItem(name: "Second", value: 24, color: .blue),
                ])
                .frame(height: 110)
            } header: {
                Text("Views")
            }


        }
        .navigationTitle("title_devmenu".localized)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.loadData() }
    }
}
