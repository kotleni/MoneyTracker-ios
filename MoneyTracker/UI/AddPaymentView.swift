//
//  AddPaymentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct AddPaymentView: View {
    @State private var priceText: String = ""
    @State private var aboutText: String = ""
    @State private var spendingBool: Bool = true
    @State private var selectedTag: Tag = Tag.other
    
    @ObservedObject var viewModel: MainViewModel
    @Binding var isSheetShow: Bool
    
    var body: some View {
        NavigationView {
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
                            Text("field_about".localized)
                            Spacer()
                            TextField("hint_necessarily".localized, text: $aboutText)
                                .multilineTextAlignment(.trailing)
                                .frame(width: UIScreen.main.bounds.width / 3)
                        }
                        if spendingBool {
                            HStack {
                                Text("Тэг".localized)
                                Spacer()
                                Picker("", selection: $selectedTag) {
                                    ForEach(Tag.allCases, id: \.self) { tag in
                                        Text(tag.rawValue.localized)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                    } footer: {
                        Text("hint_payment".localized)
                    }
                }
                .navigationBarTitle("label_newpayment".localized, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isSheetShow = false
                        } label: {
                            Text("btn_cancel".localized)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if !priceText.isEmpty && !aboutText.isEmpty {
                                // fixme: stupid code
                                let priceStr = priceText.replacingOccurrences(of: ",", with: ".")
                                let sum = MathematicalExpression(line: priceStr).makeResult()
                                guard let fl = Float(spendingBool ? "-\(sum)" : "\(sum)") else { return }
                                let about = aboutText
                                let tag = selectedTag
                                
                                viewModel.addPayment(price: fl, about: about, tag: tag)
                                //viewModel.loadAll()
                                HapticManager.shared.success()
                                
                                isSheetShow = false
                                
                                priceText = ""
                                aboutText = ""
                                selectedTag = Tag.other
                                spendingBool = false
                            } else {
                                HapticManager.shared.error()
                            }
                        } label: {
                            Text("btn_next".localized)
                        }
                    }
                }
            }
        }
    }
}
