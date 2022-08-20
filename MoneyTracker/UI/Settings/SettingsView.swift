//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
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
        Form {
            Section {
                // notif
                SettingsItemView(title: "btn_notifchange".localized, action: {
                    if(viewModel.isPremium) {
                        router.route(to: \.notifications)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }, value: "")
                
                // currency
                SettingsItemView(title: "btn_currencychange".localized, action: {
                    router.route(to: \.currencyEditor)
                }, value: viewModel.currency)
                
                // tags
                SettingsItemView(title: "btn_edittags".localized, action: {
                    router.route(to: \.tagsEditor)
                }, value: "")
            } header: {
                Text("settings_main".localized)
            }

            Section {
                // premium
                SettingsItemView(title: "btn_premium".localized, action: {
                    router.route(to: \.premium)
                }, value: "")
                
                // developer
                if viewModel.isDeveloper {
                    SettingsItemView(title: "btn_devmenu".localized, action: {
                        router.route(to: \.developer)
                    }, value: "")
                }
                
                // reset payments
                SettingsItemView(title: "btn_export".localized, action: {
                    isShowExport = true
                }, value: "")// reset payments
                .confirmationDialog("btn_export".localized, isPresented: $isShowExport, titleVisibility: .visible) {
                    Button("btn_exportlocal".localized) {
                        isExportLocal = true
                        viewModel.setLoading(isEnabled: true)
                        viewModel.exportData()
                    }
                }
                
                // reset payments
                SettingsItemView(title: "btn_resetpay".localized, action: {
                    if(viewModel.isPremium) {
                        router.route(to: \.resetPayments)
                    } else {
                        self.toastText = "btn_premiumwarn".localized
                        self.isShowToast = true
                    }
                }, value: "")
                
                // about
                SettingsItemView(title: "btn_aboutapp".localized, action: {
                    router.route(to: \.aboutApp)
                }, value: "")
            } header: {
                Text("settings_other".localized)
            }
            
            if viewModel.isLoading {
                HStack {
                    ProgressView()
                        .padding(4)
                    Text("label_loading".localized)
                        .opacity(0.8)
                }
            }
            
            if !viewModel.isPremium && !viewModel.isAdError {
                ZStack {
                    AdBanner(onUpdate: { isSuccess in
                        if isSuccess {
                            viewModel.setAdLoaded(isLoaded: true)
                        } else {
                            viewModel.setAdError(isError: true)
                        }
                    })
                    .if(viewModel.isAdLoaded) { banner in
                        banner.frame(height: 100)
                    }
                    
                    if !viewModel.isAdLoaded {
                        ProgressView()
                    }
                }
            }
        }
        .background(Color("MainBackground"))
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_settings".localized)
        .fileExporter(isPresented: $viewModel.isExportJson, document: JsonDocument(text: viewModel.exportJson), contentType: .text, defaultFilename: "export\(DateFormatter().string(from: Date())).json", onCompletion: { result in
        })
        .onAppear { viewModel.loadData() }
    }
}

struct SettingsPreview: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel.init(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), storeManager: StoreManager(keychain: KeychainManager(), productsIDs: .init()), keychainManager: KeychainManager()))
    }
}
