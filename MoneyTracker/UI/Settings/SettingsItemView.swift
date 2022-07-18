//
//  SettingsItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct SettingsItemView: View {
    let title: String
    let imageName: String
    let imageColor: Color
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .frame(width: 22, height: 22)
                .padding(4)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(imageColor))
            Button(action: {
                action()
            }, label: {
                HStack {
                    Text(title)
                    Spacer()
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

