//
//  SettingsItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct SettingsItemView: View {
    let title: String
    let action: () -> Void
    let value: String?
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                HStack {
                    Text(title)
                    Spacer()
                    if value != nil {
                        Text(value!)
                            .opacity(0.5)
                    }
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            })
            .padding(.leading, 4)
            .padding(.trailing, 2)
            .foregroundColor(Color("DefaultText"))
        }
    }
}

