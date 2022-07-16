//
//  MainView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShowSheet: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
               ProgressView()
            } else {
                HStack {
                    VStack {
                        Text("\(String(format: "%.2f", viewModel.totalBalance)) \(viewModel.priceType)")
                        Text("label_balance".localized)
                            .foregroundColor(Color.gray)
                    }
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button {
                        isShowSheet = true
                    } label: {
                        Label("btn_add".localized, systemImage: "plus.circle.fill")
                    }
                    Spacer()
                    Picker(selection: $viewModel.selectedFilter) {
                        Text("filter_all".localized)
                            .tag(Filter.all.rawValue)
                        ForEach(Tag.allCases, id: \.self) { tag in
                            Text(tag.rawValue.localized)
                                .tag(tag.rawValue)
                        }
                    } label: {
                        Text("label_filter".localized)
                    }

                    Spacer()
                }
                PaymentsView(viewModel: viewModel)
            }
        }
        .onAppear { viewModel.loadAll() }
        .sheet(isPresented: $isShowSheet, content: {
            AddPaymentView(viewModel: viewModel, isSheetShow: $isShowSheet)
        })
    }
}
