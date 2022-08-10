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
    
    @State private var isNeedPadding: Bool = true
    
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
            .if(isNeedPadding, content: { view in
                view
                    .padding(.leading, 4)
                    .padding(.trailing, 2)
            })
            .foregroundColor(Color("DefaultText"))
        }
    }
    
    func withoutPaddings() -> some View {
        isNeedPadding = false
        return self
    }
}

struct SettingsItemPreview: PreviewProvider {
    static var previews: some View {
        SettingsItemView(title: "title", action: {}, value: nil)
        SettingsItemView(title: "title2", action: {}, value: "value")
    }
}
