//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import UIKit
import SwiftUI

struct DevMenuView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Form {
            // quick add payment btn
            Button {
                viewModel.addPayment(price: Float(Int.random(in: -999...999)), about: "Undefined", tag: Tag.getDefault())
            } label: {
                Text("Quick add payment")
            }
            
            // quick add 1000 payments btn
            Button {
                let _ = PaymentsManager.shared.addPayment(price: Float(Int.random(in: -999...999)), about: "Undefined", tag: Tag.getDefault(), copies: 999)
            } label: {
                Text("Quick add 1000 payments")
            }

            // toggle main loading stage
            Button {
                viewModel.isLoading.toggle()
            } label: {
                Text("Toggle main loading stage")
            }

            // toggle premium stage
            Button {
                viewModel.isPremium.toggle()
            } label: {
                Text("Toggle premium stage")
            }
        }
        .navigationTitle("Developer Menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}
