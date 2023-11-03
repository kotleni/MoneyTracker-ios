//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 12.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var isShowToast: Bool = false
    @State private var toastText: String = ""
    @State private var isShowExport: Bool = false
    @State private var isExportLocal: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Form {
                    if !viewModel.isPremium {
                        Section {
                            HStack {
                                Image(systemName: "star")
                                    .foregroundColor(Color("AccentColor"))
                                // premium
                                SettingsItemView(title: "btn_premium".localized, action: {
                                    showPremium()
                                }, value: nil, isLocked: false)
                            }
                        } header: {
                            Text("label_fullversion".localized)
                        }
                    }

                    Section {
                        // notif
                        SettingsItemView(title: "btn_notifchange".localized, action: {
                            if viewModel.isPremium {
                                router.route(to: \.notifications)
                            } else {
                                showPremium()
                            }
                        }, value: nil, isLocked: !viewModel.isPremium)
                        
                        // currency
                        SettingsItemView(title: "btn_currencychange".localized, action: {
                            router.route(to: \.currencyEditor)
                        }, value: viewModel.currency, isLocked: false)
                        
                        // tags
                        SettingsItemView(title: "btn_edittags".localized, action: {
                            router.route(to: \.tagsEditor)
                        }, value: nil, isLocked: false)
                    } header: {
                        Text("settings_main".localized)
                    }

                    Section {
                        // export data
                        SettingsItemView(title: "btn_export".localized, action: {
                            if viewModel.isPremium {
                                isShowExport = true
                            } else {
                                showPremium()
                            }
                        }, value: nil, isLocked: !viewModel.isPremium)
                        .confirmationDialog("btn_export".localized, isPresented: $isShowExport, titleVisibility: .visible) {
                            Button("btn_exportlocal".localized) {
                                isExportLocal = true
                                viewModel.setLoading(isEnabled: true)
                                viewModel.exportData()
                            }
                        }
                        
                        // reset payments
                        SettingsItemView(title: "btn_resetpay".localized, action: {
                            if viewModel.isPremium {
                                router.route(to: \.resetPayments)
                            } else {
                                showPremium()
                            }
                        }, value: nil, isLocked: !viewModel.isPremium)
                        
                        // about
                        SettingsItemView(title: "btn_aboutapp".localized, action: {
                            router.route(to: \.aboutApp)
                        }, value: nil, isLocked: false)
                    } header: {
                        Text("settings_other".localized)
                    }
                    
//                    if !viewModel.isPremium && !viewModel.isAdError {
//                        Section {
//                            ZStack {
//                                AdBanner(onUpdate: { isSuccess in
//                                    if isSuccess {
//                                        viewModel.setAdLoaded(isLoaded: true)
//                                    } else {
//                                        viewModel.setAdError(isError: true)
//                                    }
//                                })
//                                .if(viewModel.isAdLoaded) { banner in
//                                    banner.frame(height: 100)
//                                }
//                                
//                                if !viewModel.isAdLoaded {
//                                    ProgressView()
//                                }
//                            }
//                        } header: {
//                            Text("label_adbanner".localized)
//                        }
//                    }
                }
                .background(Color("MainBackground"))
                .toast(message: toastText, isShowing: $isShowToast, config: .init())
                .navigationTitle("title_settings".localized)
                .fileExporter(
                    isPresented: $viewModel.isExportJson,
                    document: JsonDocument(text: viewModel.exportJson),
                    contentType: .text,
                    defaultFilename: "export\(DateFormatter().string(from: Date())).json", onCompletion: { _ in }
                )
            }
        }
        .onAppear { viewModel.loadData() }
    }
    
    private func showPremium() {
        router.route(to: \.premium)
    }
}

struct SettingsPreview: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel.init(managersContainer: .getForPreview()))
    }
}
