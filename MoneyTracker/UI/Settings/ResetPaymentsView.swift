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
                        Text("label_warnresepay".localized)
                    }

                }
            }
        }
        .alert(isPresented: $isShowResetPaymentsAlert) {
            Alert(title: Text("label_deletepayments".localized), primaryButton: .destructive(Text("btn_yes".localized), action: {
                viewModel.removeAllPayments()
                isShowResetPaymentsAlert = false
                isShowResetPaymentsToast = true
            }), secondaryButton: .cancel(Text("btn_no".localized), action: {
                isShowResetPaymentsAlert = false
            }))
        }
        //MARK: Проверь правильно переписал алерты под 14 ios или нет
//        .alert("label_deletepayments".localized, isPresented: $isShowResetPaymentsAlert, actions: {
//            Button("btn_yes".localized) {
//                viewModel.removeAllPayments()
//                isShowResetPaymentsAlert = false
//                isShowResetPaymentsToast = true
//            }
//            Button("btn_no".localized) {
//                isShowResetPaymentsAlert = false
//            }
//        })
        .toast(message: "toast_paymentsdeleted".localized, isShowing: $isShowResetPaymentsToast, config: .init())
        .navigationTitle("Сброс платежей")
        .navigationBarTitleDisplayMode(.inline)
    }
}
