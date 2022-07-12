//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    @State private var payments: [Payment] = []
    
    @State private var priceType: String = "UAH"
    @State private var totalBalance: Float = 0
    
    @State private var isShowSheet: Bool = false
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(String(format: "%.2f", totalBalance)) \(priceType)")
                }
                HStack {
                    Text("Баланс")
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
                Button {
                    isShowAlert = true
                } label: {
                    Label("Удалить все".localized, systemImage: "xmark.circle.fill")
                }
                Spacer()
            }

            List {
                if payments.count > 0 {
                    ForEach(payments, id: \.self) { payment in
                        HStack(spacing: 0) {
                            Text(payment.about!)
                            Spacer()
                            Text("\(String(format: "%.2f", payment.price)) \(priceType)")
                                .foregroundColor(payment.price < 0 ? Color.init(.sRGB, red: 245/255, green: 97/255, blue: 76/255, opacity: 1.0) : Color.init(.sRGB, red: 81/255, green: 187/255, blue: 116/255, opacity: 1.0))
                        }
                    }
                    .onDelete { indexSet in
                        CoreDataManager.shared.removePayment(index: indexSet.first!)
                        payments = CoreDataManager.shared.getPayments()
                    }
                } else { // is empty
                    Text("hint_empty".localized)
                }
                
            }
        }
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(isSheetShow: $isShowSheet, payments: $payments)
        })
        .onAppear { onStart() }
    }
    
    private func mathPaymentsPrice() -> Float {
        var value: Float = 0.0
        payments.forEach { payment in
            value += payment.price
        }
        return value
    }
    
    private func onStart() {
        DispatchQueue.global(qos: .userInitiated).async {
            payments = CoreDataManager.shared.getPayments()
            priceType = StorageManager.shared.getPriceType()
            totalBalance = mathPaymentsPrice()
        }
    }
}

