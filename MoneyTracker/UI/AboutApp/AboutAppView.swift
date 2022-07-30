//
//  AboutAppView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct AboutAppView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: AboutAppViewModel
    
    var body: some View {
        Form {
            Section {
                DisclosureGroup {
                    ForEach(Static.developers, id: \.self) { developer in
                        HStack {
                            Text("\(developer.name)")
                            Spacer()
                            Text("\(developer.about)")
                                .opacity(0.6)
                        }
                    }
                } label: {
                    Text("label_developers".localized)
                }

                
                // version text
                Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
                    .onLongPressGesture {
                        viewModel.enableDeveloper()
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                    }
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
}

struct AboutAppPreview: PreviewProvider {
    static var previews: some View {
        AboutAppView(viewModel: AboutAppViewModel(storageManager: StorageManager()))
    }
}
