//
//  PaymentsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct PaymentsView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        List {
            if viewModel.payments.count > 0 {
                ForEach(viewModel.payments, id: \.self) { payment in
                    if isFilterOk(payment: payment) {
                        PaymentItemView(payment: payment, viewModel: viewModel)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deletePayment(index: indexSet.first!)
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
    
    /// Check filter for payment
    private func isFilterOk(payment: Payment) -> Bool {
        // is all
        if viewModel.selectedFilter == "filter_all" {
            return true
        }
        
        // is selected tag
        let paymentTag = (payment.tag == nil) ? Tag.getDefault().name! : payment.tag!
        if viewModel.selectedFilter == paymentTag && payment.price < 0 {
            return true
        }
        
        return false
    }
}
