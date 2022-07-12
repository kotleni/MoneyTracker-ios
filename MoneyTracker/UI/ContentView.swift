//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isSheetShow: Bool = false
    @State private var isAlertShow: Bool = false
    @State private var payments: [Payment] = []
    @State private var priceText: String = ""
    @State private var aboutText: String = ""
    @State private var spendingBool: Bool = false
    @State private var priceType: String = "UAH"
    
    var body: some View {
        NavigationView {
            MainView(payments: $payments, priceType: $priceType)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            isSheetShow = true
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("btn_add".localized)
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("label_payments".localized)
        }
        .onAppear {
            priceType = StorageManager.shared.getPriceType()
        }
        .sheet(isPresented: $isSheetShow) {
            NavigationView {
                AddView(priceText: $priceText, aboutText: $aboutText, spendingBool: $spendingBool)
                    .navigationBarTitle("label_newpayment".localized, displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isSheetShow = false
                            } label: {
                                Text("btn_cancel".localized)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                if !priceText.isEmpty && !aboutText.isEmpty {
                                    guard let fl = Float(spendingBool ? "-\(priceText)" : priceText) else { return }
                                    
                                    CoreDataManager.shared.addPayment(price: fl, about: aboutText)
                                    payments = CoreDataManager.shared.getPayments()
                                    isSheetShow = false
                                    
                                    priceText = ""
                                    aboutText = ""
                                    spendingBool = false
                                }
                            } label: {
                                Text("btn_next".localized)
                            }
                        }
                    }
            }
        }
    }
}

