//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI
import PieChart

// MARK: fixme
var isFirstHomeOpen = true

struct HomeView: View {
    // objects
    @EnvironmentObject var router: HomeCoordinator.Router
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    Section {
                        HomeBalanceView(
                            totalBalance: viewModel.balance.current,
                            priceType: viewModel.priceType
                        ) { // plus btn click
                            router.route(to: \.addPayments)
                        }
                        
                        HomeBalance2View(
                            totalIncome: viewModel.balance.income,
                            totalOutcome: viewModel.balance.outcome,
                            priceType: viewModel.priceType)
                        
                        if (viewModel.balance.income + viewModel.balance.outcome) != 0 {
                            PieChart(radius: 36, items: [
                                ChartItem(name: "label_expenses".localized, value: abs(Double(viewModel.balance.outcome)), color: Color("AccentColor")),
                                ChartItem(name: "label_income".localized, value: Double(viewModel.balance.income), color: Color(red: 45/255, green: 192/255, blue: 79/255))
                            ])
                            .frame(height: 110)
                        }
                    } header: {
                        Text("label_statistic".localized)
                    }
                    
                    Section {
                        if viewModel.payments.count > 0 {
                            ForEach(viewModel.payments, id: \.self) { payment in
                                if payment.isFilterOk(filter: viewModel.selectedFilter) {
                                    PaymentItemView(payment: payment, tag: viewModel.findTagByName(name: payment.tag ?? ""), priceType: viewModel.priceType)
                                }
                            }
                            .onDelete { indexSet in
                                if let index = indexSet.first {
                                    viewModel.deletePayment(index: index)
                                }
                            }
                        } else { // is empty
                            Text("label_nopayments".localized)
                        }
                        
                    } header: {
                        Text("label_payments".localized)
                    }
                    .onAppear {
                        if viewModel.storageManager.getRunsCount() == 1 && isFirstHomeOpen {
                            router.route(to: \.welcome)
                            isFirstHomeOpen = false
                        }
                    }
                }
            }
            
        }
        .navigationTitle("title_home".localized)
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct HomePreview: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel.init(managersContainer: .getForPreview()))
    }
}
