//
//  PaymentsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct PaymentsView: View {
    @Binding var payments: [Payment]
    @Binding var selectedFilter: Filter
    @Binding var priceType: String

    var body: some View {
        List {
            if payments.count > 0 {
                ForEach(payments, id: \.self) { payment in
                    if selectedFilter == Filter.all || (selectedFilter == Filter.minus && payment.price < 0) || (selectedFilter == Filter.plus && payment.price >= 0) {
                        PaymentItemView(payment: payment, priceType: priceType)
                    }
                }
                .onDelete { indexSet in
                    CoreDataManager.shared.removePayment(index: indexSet.first!)
                    payments = CoreDataManager.shared.getPayments()
                }
            } else { // is empty
                Section {
                    Text("hint_empty".localized)
                } footer: {
                    Text("hint_emptyfooter".localized)
                }
            }
            
        }
    }
}
