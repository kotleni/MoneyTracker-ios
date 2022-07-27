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
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: AboutAppViewModel
    
    var body: some View {
        Form {
            Section {
                // developer text
                Text("label_developer".localized + "\(Static.developerString)")
                    .onTapGesture {
                        trackEggs()
                    }
                
                // version text
                Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
            } header: {
                Text("label_info".localized)
            }
            
            Section {
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
                
                // policy
                Button {
                    guard let url = URL(string: Static.policyUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_policy".localized)
                }
                
                // terms
                Button {
                    guard let url = URL(string: Static.termsUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("btn_terms".localized)
                }
            } header: {
                Text("label_links".localized)
            }

        }
        .navigationTitle("title_aboutapp".localized)
        .onAppear { viewModel.loadData() }
    }
    
    // track current state of eggs
    private func trackEggs() {
        eggsCounter += 1
        if !viewModel.isDeveloper && eggsCounter == 2 {
            viewModel.enableDeveloper()
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

struct AboutAppPreview: PreviewProvider {
    static var previews: some View {
        AboutAppView(viewModel: AboutAppViewModel(storageManager: StorageManager()))
    }
}
