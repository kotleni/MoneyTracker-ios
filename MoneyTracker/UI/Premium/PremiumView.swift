//
//  PremiumView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 20.07.2022.
//

import SwiftUI
import StoreKit

struct PremiumView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: PremiumViewModel
    
    var body: some View {
        VStack {
            Text("label_premiumsubscribe".localized)
                .font(.system(size: 24).bold())
                .padding(16)
            
            ScrollView {
                VStack {
                    PremiumItemView(iconName: "dot.circle.and.cursorarrow", name: "label_tip1".localized, about: "label_tip1detail".localized)
                    PremiumItemView(iconName: "trash", name: "label_tip2".localized, about: "label_tip2detail".localized)
                    PremiumItemView(iconName: "square.and.arrow.up", name: "label_tip3".localized, about: "label_tip3detail".localized)
                    PremiumItemView(iconName: "figure.walk.diamond", name: "label_tip4".localized, about: "label_tip4detail".localized)
                }
                .padding(8)
            }
            Spacer()
            
            VStack(spacing: 0) {
                Button {
                    viewModel.purshacePremium { isSuccess in
                        if isSuccess {
                            router.pop()
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        VStack {
                            Text("btn_continue".localized)
                                .font(.system(size: 17))
                            Text("label_premiumaboutleft".localized + viewModel.premiumPrice + "label_premiumaboutright".localized)
                                .opacity(0.9)
                                .font(.system(size: 16))
                        }
                        Spacer()
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("AccentColor")))
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
            
            Button {
                router.pop()
            } label: {
                VStack {
                    Text("btn_cancel".localized)
                        .font(.system(size: 17))
                }
                .padding(8)
                .foregroundColor(Color("AccentColor"))
            }
            
            Text("label_subscribe".localized)
                .font(.system(size: 14))
                .opacity(0.6)
        }
        .padding()
        .navigationTitle("title_premium".localized)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.loadData() }
    }
}

struct PremiumPreview: PreviewProvider {
    static var previews: some View {
        PremiumView(viewModel: PremiumViewModel.init(managersContainer: .getForPreview()))
    }
}
