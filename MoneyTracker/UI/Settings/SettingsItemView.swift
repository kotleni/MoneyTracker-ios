//
//  SettingsItemView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 18.07.2022.
//

import SwiftUI

struct SettingsItemView: View {
    let title: String
    let action: () -> Void
    let value: String?
    let isLocked: Bool?
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                HStack {
                    Text(title)
                    Spacer()
                    Text(value ?? "")
                        .opacity(0.5)
                    if let isLocked = isLocked {
                        if isLocked {
                            Image(systemName: "lock")
                                .opacity(0.5)
                        }
                    }
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.gray)
                        .opacity(0.9)
                }
            })
            .foregroundColor(Color("DefaultText"))
        }
    }
}

struct SettingsItemPreview: PreviewProvider {
    static var previews: some View {
        SettingsItemView(title: "title", action: {}, value: nil, isLocked: false)
        SettingsItemView(title: "title2", action: {}, value: nil, isLocked: true)
        SettingsItemView(title: "title3", action: {}, value: "value", isLocked: false)
    }
}
