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
    @ObservedObject var viewModel: MainViewModel
    
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
                    
//                    HStack {
//                        Spacer()
//                        PizzaChart(radius: 60, items: [
//                            ChartItem(name: "Income", value: 11, color: .blue),
//                            ChartItem(name: "Expenses", value: 22, color: .red),
//                        ])
//                        .frame(width: 200, height: 200)
//                        Spacer()
//                    }
                } header: {
                    Text("label_statistic".localized)
                }
                
                Section {
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

