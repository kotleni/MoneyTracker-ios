//
//  HomeBalance2View.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct HomeBalance2View: View {
    let totalIncome: Float
    let totalOutcome: Float
    let priceType: String
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    HStack {
                        Text("\(String(format: "%.2f", totalIncome)) \(priceType)")
                            .bold()
                            .font(SwiftUI.Font.system(size: 19))
                        Spacer()
                    }
                    HStack {
                        Text("label_expenses".localized)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                Spacer()
                VStack {
                    HStack {
                        Text("\(String(format: "%.2f", totalOutcome).replacingOccurrences(of: "-", with: "")) \(priceType)")
                            .bold()
                            .font(SwiftUI.Font.system(size: 19))
                        Spacer()
                    }
                    HStack {
                        Text("label_income".localized)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
        }
    }
}
