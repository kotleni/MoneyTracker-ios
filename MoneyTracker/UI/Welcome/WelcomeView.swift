//
//  WelcomeView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 30.08.2022.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: HomeCoordinator.Router
    @ObservedObject var viewModel: WelcomeViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image("AppIconRaw")
                .resizable()
                .frame(width: 110, height: 110)
                .padding(.top, 8)
                .padding(.bottom, 8)
            Text("label_hello".localized)
                .font(.system(size: 22).bold())
                .padding(.top, 8)
            Text("label_hello2".localized)
                .multilineTextAlignment(.center)
                .font(.system(size: 17))
                .padding(.top, 1)
                .padding(.bottom, 16)
            
            Spacer()
            
            Button {
                router.pop()
            } label: {
                HStack {
                    Spacer()
                    VStack {
                        Text("btn_startusign".localized)
                            .font(.system(size: 17))
                            .padding(.top, 6)
                            .padding(.bottom, 6)
                    }
                    Spacer()
                }
                .padding(8)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color("AccentColor")))
            }
            .padding()
            
            Spacer()
                .frame(height: 60)
        }.padding()
    }
}

struct WelcomePreview: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: WelcomeViewModel(managersContainer: .getForPreview()))
    }
}
