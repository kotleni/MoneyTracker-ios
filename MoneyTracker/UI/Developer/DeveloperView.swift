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
    
    var body: some View {
        Form {
//            Button {
//                viewModel.addPayment(price: Float(Int.random(in: -999...999)), about: ":)", tag: Tag.getDefault())
//            } label: {
//                Text("btn_devaddpay".localized)
//            }
//            
//            Button {
//                viewModel.loadAllData()
//            } label: {
//                Text("btn_devupdatedata".localized)
//            }
//            
//            Toggle("btn_devpremium".localized, isOn: $viewModel.isPremium)
        }
        .navigationTitle("title_devmenu".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
