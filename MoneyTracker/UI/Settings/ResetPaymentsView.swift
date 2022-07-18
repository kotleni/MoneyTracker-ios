//
//  ResetPaymentsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct ResetPaymentsView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isShowResetPaymentsAlert: Bool = false
    @State private var isShowResetPaymentsToast: Bool = false
    
    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            VStack {
                Form {
                    Section {
                        HStack {
                            Button {
                                isShowResetPaymentsAlert = true
                            } label: {
                                Text("btn_resetpayments".localized)
                            }
                        }
                    } footer: {
                        Text("Все платежи удаляться безвозвратно")
                    }

                }
            }
        }
        .alert("label_deletepayments".localized, isPresented: $isShowResetPaymentsAlert) {
            Button("btn_yes".localized) {
                viewModel.removeAllPayments()
                isShowResetPaymentsAlert = false
                isShowResetPaymentsToast = true
            }
            Button("btn_no".localized) {
                isShowResetPaymentsAlert = false
            }
        }
        .toast(message: "toast_paymentsdeleted".localized, isShowing: $isShowResetPaymentsToast, config: .init())
        .navigationTitle("Сброс платежей")
        .navigationBarTitleDisplayMode(.inline)
    }
}
