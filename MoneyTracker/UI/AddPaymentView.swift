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
    @State private var spendingBool: Bool = false
    @State private var selectedTag: Tag = Tag.other
    
    @Binding var isSheetShow: Bool
    @Binding var payments: [Payment]
    var selectHandler: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("field_price".localized)
                        Spacer()
                        TextField("hint_necessarily".localized, text: $priceText)
                            .keyboardType(.numberPad)
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
                    HStack {
                        Text("field_expenses".localized)
                        Toggle("", isOn: $spendingBool)
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
                        .animation(.default)
                        .transition(.slide)
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
                            guard let fl = Float(spendingBool ? "-\(priceText)" : priceText) else { return }
                            let about = aboutText
                            let tag = selectedTag
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                CoreDataManager.shared.addPayment(price: fl, about: about, tag: tag)
                                
                                DispatchQueue.main.async {
                                    selectHandler()
                                    HapticManager.shared.success()
                                }
                            }
                            
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
