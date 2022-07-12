//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    @Binding var payments: [Payment]
    @Binding var priceType: String
    
    var body: some View {
        VStack {
            VStack {
                Text(String(format: "%.2f", mathPaymentsPrice()))
                    .font(.system(size: 50).bold())
                    .padding(4)
                
                Picker("Currency", selection: $priceType) {
                    ForEach(currencyList, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: priceType, perform: { value in
                    StorageManager.shared.setPriceType(type: priceType)
                })
            }
            .padding(32)
            .frame(height: 140)

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
        .onAppear {
            payments = CoreDataManager.shared.getPayments()
        }
    }
    
    private func mathPaymentsPrice() -> Float {
        var value: Float = 0.0
        payments.forEach { payment in
            value += payment.price
        }
        return value
    }
}

