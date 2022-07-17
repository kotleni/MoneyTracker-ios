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
            
            VStack {
                HStack {
                    Spacer()
                }
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
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                    
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
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                    
                }
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Text("\(String(format: "%.2f", viewModel.totalBalance)) \(viewModel.priceType)")
                        .bold()
                        .font(SwiftUI.Font.system(size: 19))
                    Spacer()
                    Button {
                        isShowSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }

            }
        }
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(viewModel: viewModel, isSheetShow: $isShowSheet)
        })
            
//            HStack {
//                VStack {
//                    Text("\(String(format: "%.2f", viewModel.totalBalance)) \(viewModel.priceType)")
//                        .bold()
//                        .font(SwiftUI.Font.system(size: 19))
//                    Text("label_balance".localized)
//                        .foregroundColor(Color.gray)
//                }
//                Spacer()
//            }
//            .padding()
            
//            HStack {
//                Spacer()
//                Button {
//                    isShowSheet = true
//                } label: {
//                    Label("btn_add".localized, systemImage: "plus.circle.fill")
//                }
//                Spacer()
//                Picker(selection: $viewModel.selectedFilter) {
//                    Text("filter_all".localized)
//                        .tag(Filter.all.rawValue)
//                    ForEach(Tag.getAll(), id: \.self) { tag in
//                        Text(tag.emoji! + " " + tag.name!)
//                            .tag(tag.name!)
//                    }
//                } label: {
//                    Text("label_filter".localized)
//                }
//
//                Spacer()
//            }
//            PaymentsView(viewModel: viewModel)
//        }
//        .navigationBarTitle("Финансы")
//        .sheet(isPresented: $isShowSheet, content: {
//            AddPaymentView(viewModel: viewModel, isSheetShow: $isShowSheet)
//        })
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    router.pushTo(view: CheckoutView.builder.makeView(SettingsView(viewModel: viewModel), withNavigationTitle: "Settings"))
//                }, label: {
//                    Image(systemName: "gear")
//                })
//            }
//        }
        
    }
}
