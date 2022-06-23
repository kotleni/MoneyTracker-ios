//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isSheetShow: Bool = false
    @State private var payments: [Payment] = []
    @State private var priceText: String = ""
    @State private var aboutText: String = ""
    @State private var spendingBool: Bool = false
    
    var body: some View {
        NavigationView {
            MainView(payments: $payments)
                .tag(0)
                .tabItem {
                    Label("Платежи", systemImage: "house")
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            isSheetShow = true
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Добавить")
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Все платежи")
        }
        .sheet(isPresented: $isSheetShow) {
            NavigationView {
                AddView(priceText: $priceText, aboutText: $aboutText, spendingBool: $spendingBool)
                    .navigationBarTitle("Новый платеж", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isSheetShow = false
                            } label: {
                                Text("Отмена")
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                CoreDataManager.shared.addPayment(price: Float(spendingBool ? "-\(priceText)" : priceText)!, about: aboutText)
                                payments = CoreDataManager.shared.getPayments()
                                isSheetShow = false
                                
                                priceText = ""
                                aboutText = ""
                                spendingBool = false
                            } label: {
                                Text("Далее")
                            }
                        }
                    }
            }
        }
    }
}

struct MainView: View {
    @Binding var payments: [Payment]
    
    var body: some View {
        VStack {
            VStack {
                Text(String(format: "%.2f", mathPaymentsPrice()))
                    .font(.system(size: 50).bold())
                    .padding(4)
                Text("UAH")
                    .lineLimit(3)
            }
            .padding(32)
            .frame(height: 140)

            List {
                Section {
                    ForEach(payments, id: \.self) { payment in
                        HStack(spacing: 0) {
                            Text(payment.about!)
                                .font(.system(size: 16).bold())
                            Spacer()
                            Text("\(String(format: "%.2f", payment.price)) UAH")
                                .font(.system(size: 16))
                        }
                        .listStyle(.grouped)
                    }
                } header: {
                    Text("Все транзакции")
                        .font(.system(size: 18).bold())
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

struct AddView: View {
    @Binding var priceText: String
    @Binding var aboutText: String
    @Binding var spendingBool: Bool
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Цена")
                        Spacer()
                        TextField("Обязательно", text: $priceText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    HStack {
                        Text("Описание")
                        Spacer()
                        TextField("Обязательно", text: $aboutText)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    
                    HStack {
                        Text("Оплата")
                        Toggle("", isOn: $spendingBool)
                    }
                } footer: {
                    Text("После создания платежа, он добавится в историю и счетчик средств обновится.")
                }
            }
        }
    }
}
