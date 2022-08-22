//
//  PremiumItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import SwiftUI

struct PremiumItemView: View {
    let iconName: String
    let name: String
    let about: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(.blue)
            
            VStack {
                HStack {
                    Text(name)
                        .bold()
                        .font(.system(size: 17))
                    Spacer()
                }
                HStack {
                    Text(about)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    Spacer()
                }
            }
            .padding(.leading, 8)
        }
        .padding(8)
    }
}

struct PremiumItemPreview: PreviewProvider {
    static var previews: some View {
        PremiumItemView(iconName: "trash", name: "Name", about: "About")
    }
}
