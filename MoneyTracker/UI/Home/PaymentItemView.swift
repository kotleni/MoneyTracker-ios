//
//  PaymentItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct PaymentItemView: View {
    var payment: Payment
    var tag: Tag?
    var priceType: String
    
    var body: some View {
        HStack {
            if payment.price < 0 {
                Text((tag == nil) ? "❓" : tag?.emoji ?? "")
                    .font(.system(size: 28))
            }
            VStack {
                HStack {
                    Text("\(String(format: "%.2f", payment.price)) \(priceType)")
                        .bold()
                        .font(.system(size: 16))
                    Spacer()
                }
                HStack {
                    Text((payment.about == nil) ? "..." : payment.about ?? "")
                        .font(.system(size: 14))
                        .opacity(0.5)
                    Spacer()
                }
            }
            .padding(.leading, 8)
            Spacer()
            VStack {
                Text("\((payment.date ?? Date()).getDateString())")
                    .font(.system(size: 14))
                    .opacity(0.5)
                Spacer()
            }
        }
    }
}
