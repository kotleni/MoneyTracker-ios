//
//  PremiumItemView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import SwiftUI

struct PremiumItemView: View {
    let name: String
    let about: String
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .bold()
                    .font(.system(size: 16))
                Spacer()
            }
            HStack {
                Text(about)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Spacer()
            }
        }
    }
}

struct PremiumItemPreview: PreviewProvider {
    static var previews: some View {
        PremiumItemView(name: "Name", about: "About")
    }
}
