//
//  PaymentItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct PaymentItemView: View {
    var payment: Payment
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Text((Tag.getByName(name: payment.tag!) == nil) ? "" : Tag.getByName(name: payment.tag!)!.emoji!)
                .font(.system(size: 28))
            VStack {
                HStack {
                    Text("\(String(format: "%.2f", payment.price)) \(viewModel.priceType)")
                        .bold()
                        .font(.system(size: 16))
                    Spacer()
                }
                HStack {
                    Text((payment.about == nil) ? "..." : payment.about!)
                        .font(.system(size: 14))
                        .opacity(0.5)
                    Spacer()
                }
            }
            .padding(.leading, 8)
            Spacer()
            VStack {
                Text("\(payment.date!.getTimeString())")
                    .font(.system(size: 14))
                    .opacity(0.5)
                Spacer()
            }
        }
        .padding(8)
    }
}
