//
//  AddView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

struct AddView: View {
    @Binding var priceText: String
    @Binding var aboutText: String
    @Binding var spendingBool: Bool
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "")
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
                } footer: {
                    Text("hint_payment".localized)
                }
            }
        }
    }
}
