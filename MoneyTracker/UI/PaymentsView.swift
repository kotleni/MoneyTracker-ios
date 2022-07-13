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
                        HStack(spacing: 0) {
                            Text(payment.about!)
                            Spacer()
                            Text("\(String(format: "%.2f", payment.price)) \(priceType)")
                                .foregroundColor(payment.price < 0 ? Color.init(.sRGB, red: 245/255, green: 97/255, blue: 76/255, opacity: 1.0) : Color.init(.sRGB, red: 81/255, green: 187/255, blue: 116/255, opacity: 1.0))
                        }
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
                    Text("Добавьте новый при помощи кнопки выше.")
                }
            }
            
        }
    }
}

struct PaymentsPreviews: PreviewProvider {
    static var previews: some View {
        PaymentsView(payments: .constant([]), selectedFilter: .constant(Filter.all), priceType: .constant("USD"))
    }
}
