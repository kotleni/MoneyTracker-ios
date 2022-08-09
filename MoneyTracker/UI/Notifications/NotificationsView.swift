//
//  NotificationsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    
    @ObservedObject var viewModel: NotificationsViewModel
    
    @State private var isShowToast: Bool = false
    @State private var toastText: String = ""
    
    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            VStack {
                Form {
                    Section {
                        Toggle("label_notifications".localized, isOn: $viewModel.isNotifOn)
                            .onChange(of: viewModel.isNotifOn) { value in
                                viewModel.setNotifications(state: viewModel.isNotifOn)
                            }
                    } footer: {
                        Text("label_notiffooter".localized)
                    }

                }
            }
        }
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_notifications".localized)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.loadData() }
    }
}

struct NotificationsPreview: PreviewProvider {
    static var previews: some View {
        NotificationsView(viewModel: NotificationsViewModel.init(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), storeManager: StoreManager(keychain: KeychainManager(), productsIDs: .init()), keychainManager: KeychainManager()))
    }
}
