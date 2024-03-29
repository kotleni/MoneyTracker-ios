//
//  AboutAppView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 18.07.2022.
//

import SwiftUI

struct AboutAppView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: AboutAppViewModel
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    DisclosureGroup {
                        ForEach(Static.developers, id: \.self) { developer in
                            SettingsItemView(title: developer.name, action: {
                                developer.url.openAsLink()
                            }, value: developer.about, isLocked: false)
                        }
                    } label: {
                        Text("label_developers".localized)
                    }
                    
                    // version text
                    Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
                        .onLongPressGesture {
                            router.route(to: \.developer)
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                        }
                } header: {
                    Text("label_info".localized)
                }
                
                Section {
                    // appstore btn
//                    Button {
//                        guard let url = URL(string: Static.appstoreUrl) else { return }
//                        UIApplication.shared.open(url)
//                    } label: {
//                        Text("btn_appinappstore".localized)
//                    }
                    
                    // github btn
                    Button {
                        guard let url = URL(string: Static.githubUrl) else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Text("btn_appingithub".localized)
                    }
                } header: {
                    Text("label_links".localized)
                }

            }
        }
        .navigationTitle("title_aboutapp".localized)
        .onAppear { viewModel.loadData() }
    }
}

struct AboutAppPreview: PreviewProvider {
    static var previews: some View {
        AboutAppView(viewModel: AboutAppViewModel.init(managersContainer: .getForPreview()))
    }
}
