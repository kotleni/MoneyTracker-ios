//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
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
                    HStack {
                        VStack {
                            HStack {
                                Text("\(String(format: "%.2f", viewModel.totalBalance)) \(viewModel.priceType)")
                                    .bold()
                                    .font(SwiftUI.Font.system(size: 19))
                                Spacer()
                            }
                            HStack {
                                Text("Баланс")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        Spacer()
                        Button {
                            isShowSheet = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                    }
                    //.padding(8)
                    
                    HStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("\(String(format: "%.2f", viewModel.totalIncome)) \(viewModel.priceType)")
                                        .bold()
                                        .font(SwiftUI.Font.system(size: 19))
                                    Spacer()
                                }
                                HStack {
                                    Text("Доход")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                            Spacer()
                            VStack {
                                HStack {
                                    Text("\(String(format: "%.2f", viewModel.totalOutcome).replacingOccurrences(of: "-", with: "")) \(viewModel.priceType)")
                                        .bold()
                                        .font(SwiftUI.Font.system(size: 19))
                                    Spacer()
                                }
                                HStack {
                                    Text("Расходы")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                        }
                    }
                    //.padding(8)
                } header: {
                    Text("Статистика")
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
                        Text("Вы еще не добавили никаких платежей.".localized)
                    }
                } header: {
                    Text("Все платежи")
                }
            }
            
        }
        .navigationTitle("Финансы")
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
