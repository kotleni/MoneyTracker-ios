//
//  AddPaymentView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 12.07.2022.
//

import SwiftUI

struct AddPaymentView: View {
    @EnvironmentObject var router: HomeCoordinator.Router
    @ObservedObject var viewModel: AddPaymentViewModel
    
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.spendingBool) {
                Text("segment_expenses".localized)
                    .tag(true)
                Text("segment_income".localized)
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding()
            
            Form {
                Section {
                    HStack {
                        Text("field_price".localized)
                        Spacer()
                        TextField("hint_necessarily".localized, text: $viewModel.priceText)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    HStack {
                        Text("field_desc".localized)
                        Spacer()
                        TextField("hint_necessarily".localized, text: $viewModel.aboutText)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    if viewModel.spendingBool {
                        HStack {
                            Text("label_tag".localized)
                            Spacer()
                            Picker("", selection: $viewModel.selectedTag) {
                                ForEach(viewModel.tags, id: \.self) { tag in
                                    Text((tag.emoji ?? "") + " " + (tag.name ?? ""))
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                } footer: {
                    Text("hint_payment".localized)
                }
            }
            .navigationBarTitle("title_newpayment".localized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.tryAddPayment {
                            router.popToRoot()
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                        }
                    } label: {
                        Text("btn_next".localized)
                    }
                }
            }
        }
        .toast(message: viewModel.errorText, isShowing: $viewModel.isError, config: .init(isError: true))
        .onAppear { viewModel.loadData() }
    }
}

struct AddPaymentPreview: PreviewProvider {
    static var previews: some View {
        AddPaymentView(viewModel: AddPaymentViewModel.init(managersContainer: .getForPreview()))
    }
}
