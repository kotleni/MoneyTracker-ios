//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    @State private var payments: [Payment] = []
    
    @State private var priceType: String = "USD"
    @State private var totalBalance: Float = 0
    
    @State private var isShowSheet: Bool = false
    
    @State private var selectedFilter: String = Filter.all.rawValue
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("\(String(format: "%.2f", totalBalance)) \(priceType)")
                    Text("label_balance".localized)
                        .foregroundColor(Color.gray)
                }
            }
            .padding()
            HStack {
                Spacer()
                Button {
                    isShowSheet = true
                } label: {
                    Label("btn_add".localized, systemImage: "plus.circle.fill")
                }
                Spacer()
                Picker(selection: $selectedFilter) {
                    Text("filter_all".localized)
                        .tag(Filter.all.rawValue)
//                    Text("filter_plus".localized)
//                        .tag(Filter.plus.rawValue)
                    ForEach(Tag.allCases, id: \.self) { tag in
                        Text(tag.rawValue.localized)
                            .tag(tag.rawValue)
                    }
                } label: {
                    Text("label_filter".localized)
                }

                Spacer()
            }
            PaymentsView(payments: $payments, selectedFilter: $selectedFilter, priceType: $priceType)
        }
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(isSheetShow: $isShowSheet, payments: $payments, selectHandler: {
                loadAll()
            })
        })
        .onAppear { loadAll() }
    }
    
    private func mathPaymentsPrice() -> Float {
        var value: Float = 0.0
        payments.forEach { payment in
            value += payment.price
        }
        return value
    }
    
    private func loadAll() {
        DispatchQueue.global(qos: .userInitiated).async {
            payments = CoreDataManager.shared.getPayments()
            priceType = StorageManager.shared.getPriceType()
            totalBalance = mathPaymentsPrice()
        }
    }
}
