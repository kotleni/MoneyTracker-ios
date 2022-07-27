//
//  PremiumBannerView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct PremiumBannerView: View {
    var isPremium: Bool
    var premiumPrice: String
    let action: () -> Void
    
    var body: some View {
        if isPremium {
            Text("label_premiumactive".localized)
        } else if premiumPrice.isEmpty {
            ProgressView()
        } else {
            Button(action: {
                action()
            }, label: {
                VStack {
                    HStack {
                        Text("label_premiumsubscribe".localized)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    HStack {
                        Text("label_premiumaboutleft".localized + premiumPrice + "label_premiumaboutright".localized)
                            .opacity(0.7)
                            .font(.system(size: 16))
                        Spacer()
                    }
                }
            })
        }
    }
}

