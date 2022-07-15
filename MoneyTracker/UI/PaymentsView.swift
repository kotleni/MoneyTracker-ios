//
//  PaymentsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct PaymentsView: View {
    @Binding var payments: [Payment]
    @Binding var selectedFilter: String
    @Binding var priceType: String

    var body: some View {
        List {
            if payments.count > 0 {
                ForEach(payments, id: \.self) { payment in
                    if isFilterOk(payment: payment) {
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
    
    private func isFilterOk(payment: Payment) -> Bool {
        let paymentTag = (payment.tag == nil) ? Tag.other.rawValue : payment.tag!
        
        // is all
        if (selectedFilter == "filter_all") {
            return true
        }
        
        // is plus
//        if (selectedFilter == "filter_plus") && payment.price > 0 {
//            return true
//        }
        
        if payment.price < 0 {
            return false
        }
        
        // check tags
        for tag in Tag.allCases {
            if selectedFilter == paymentTag {
                return true
            }
        }
        
        return false
    }
}
