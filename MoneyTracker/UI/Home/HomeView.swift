//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct HomeView: View {
    // objects
    @EnvironmentObject var router: HomeCoordinator.Router
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var isShowSheet: Bool = false

    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            List {
                Section {
                    HomeBalanceView(
                        totalBalance: viewModel.totalBalance,
                        priceType: viewModel.priceType
                    ) { // plus btn click
                        isShowSheet = true
                    }
                    
                    HomeBalance2View(
                        totalIncome: viewModel.totalIncome,
                        totalOutcome: viewModel.totalOutcome,
                        priceType: viewModel.priceType)
                } header: {
                    Text("label_statistic".localized)
                }
                
                Section {
                    if viewModel.payments.count > 0 {
                        ForEach(viewModel.payments, id: \.self) { payment in
                            if payment.isFilterOk(filter: viewModel.selectedFilter) {
                                PaymentItemView(payment: payment, viewModel: viewModel)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.deletePayment(index: indexSet.first!)
                        }
                    } else { // is empty
                        Text("label_nopayments".localized)
                    }
                    
                    
                } header: {
                    Text("label_payments".localized)
                }
            }
            
        }
        .navigationTitle("title_home".localized)
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(viewModel: viewModel, isSheetShow: $isShowSheet)
        })
        
    }
}
