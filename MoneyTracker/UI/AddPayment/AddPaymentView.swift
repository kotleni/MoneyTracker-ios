//
//  AddPaymentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct AddPaymentView: View {
    @EnvironmentObject var router: HomeCoordinator.Router
    
    @State private var priceText: String = ""
    @State private var aboutText: String = ""
    @State private var spendingBool: Bool = true
    @State private var selectedTag: Tag = Tag.getDefault()
    
    @ObservedObject var viewModel: AddPaymentViewModel
    @State private var isError: Bool = false
    
    var body: some View {
        VStack {
            Picker("", selection: $spendingBool) {
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
                        TextField("hint_necessarily".localized, text: $priceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    HStack {
                        Text("field_desc".localized)
                        Spacer()
                        TextField("hint_necessarily".localized, text: $aboutText)
                            .multilineTextAlignment(.trailing)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }
                    if spendingBool {
                        HStack {
                            Text("label_tag".localized)
                            Spacer()
                            Picker("", selection: $selectedTag) {
                                ForEach(viewModel.tags, id: \.self) { tag in
                                    Text(tag.emoji! + " " + tag.name!)
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
                        if PriceValidator.validate(str: priceText) && !aboutText.isEmpty {
                            viewModel.tryAddPayment(
                                priceText: priceText,
                                aboutText: aboutText,
                                spendingBool: spendingBool,
                                selectedTag: selectedTag)
                            
                            router.popToRoot()
                            
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                            
                            priceText = ""
                            aboutText = ""
                            selectedTag = Tag.getDefault()
                            spendingBool = false
                        } else {
                            isError = true
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                        }
                    } label: {
                        Text("btn_next".localized)
                    }
                }
            }
        }
        .toast(message: "toast_invalidpaydata".localized, isShowing: $isError, config: .init())
        .onAppear { viewModel.loadData() }
    }
}

struct AddPaymentPreview: PreviewProvider {
    static var previews: some View {
        AddPaymentView(viewModel: AddPaymentViewModel(paymentsManager: PaymentsManager(), tagsManager: TagsManager()))
    }
}
