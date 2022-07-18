//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import UIKit
import SwiftUI

struct DeveloperView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Form {
            Button {
                viewModel.addPayment(price: Float(Int.random(in: -999...999)), about: "Undefined", tag: Tag.getDefault())
            } label: {
                Text("Добавить платеж")
            }
            
            Button {
                viewModel.loadAllData()
            } label: {
                Text("Обновить данные")
            }
            
            Toggle("Премиум подписка", isOn: $viewModel.isPremium)
        }
        .navigationTitle("Меню разработчика")
        .navigationBarTitleDisplayMode(.inline)
    }
}
