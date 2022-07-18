//
//  HomeBalanceView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct HomeBalanceView: View {
    let totalBalance: Float
    let priceType: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("\(String(format: "%.2f", totalBalance)) \(priceType)")
                        .bold()
                        .font(SwiftUI.Font.system(size: 19))
                    Spacer()
                }
                HStack {
                    Text("Баланс")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            Spacer()
            Button {
                action()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
        }
    }
}
