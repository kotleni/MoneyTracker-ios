//
//  AboutAppView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

// eggs counter
fileprivate var eggsCounter: Int = 0

struct AboutAppView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Form {
            // developer text
            Text("label_developer".localized + "\(Static.developerString)")
                .onTapGesture {
                    trackEggs()
                }
            
            // version text
            Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
            
            // appstore btn
            Button {
                guard let url = URL(string: Static.appstoreUrl) else { return }
                UIApplication.shared.open(url)
            } label: {
                Text("btn_appinappstore".localized)
            }
            
            // github btn
            Button {
                guard let url = URL(string: Static.githubUrl) else { return }
                UIApplication.shared.open(url)
            } label: {
                Text("btn_appingithub".localized)
            }
        }
        .navigationTitle("title_aboutapp".localized)
    }
    
    // track current state of eggs
    private func trackEggs() {
        eggsCounter += 1
        if eggsCounter == 2 {
            viewModel.isDeveloperOn = true
            HapticManager.shared.success()
        }
    }
}

