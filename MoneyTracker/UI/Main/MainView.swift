//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    // objects
    @EnvironmentObject var router: CheckoutViewsRouter
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isShowSheet: Bool = false

    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // info card
                VStack {
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
                                    Text("Затраты")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color("CardBackground")))
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                
                // payments and settings btns
                VStack {
                    HStack {
                        HStack {
                            Spacer()
                            Button {
                                router.pushTo(view: CheckoutView.builder.makeView(PaymentsView(viewModel: viewModel), withNavigationTitle: "Payments"))
                            } label: {
                                Label("Платежи", systemImage: "wallet.pass")
                                    .font(.system(size: 16).bold())
                            }
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color("CardBackground")))
                        
                        HStack {
                            Spacer()
                            Button {
                                router.pushTo(view: CheckoutView.builder.makeView(SettingsView(viewModel: viewModel), withNavigationTitle: "Settings"))
                            } label: {
                                Label("Настройки", systemImage: "gear")
                                    .font(.system(size: 16).bold())
                            }
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color("CardBackground")))
                        
                    }
                    Spacer()
                }
                .padding()
                
                // bottombar divider
                Divider()
                    .frame(height: 1)
                
                // bottombar
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
                .padding()
                .background(Color("CardBackground"))
            }
        }
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(viewModel: viewModel, isSheetShow: $isShowSheet)
        })
        
    }
}
