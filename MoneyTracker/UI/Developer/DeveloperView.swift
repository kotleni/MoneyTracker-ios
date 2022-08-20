//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: DeveloperViewModel
    
    var body: some View {
        Form {
            Section {
                Button { viewModel.addSpecialPayments() }
                    label: { Text("Add payments for screenshot") }
                Button { viewModel.removeAllPayments() }
                    label: { Text("Remove all payments") }
                
                Toggle(isOn: $viewModel.isExperimental, label: { Text("Experimental features") })
                Toggle(isOn: $viewModel.isNotifEnable, label: { Text("Notifications toggle") })
                Toggle(isOn: $viewModel.isDeveloper, label: { Text("Developer unlocked") })
            } header: {
                Text("Experimental")
            }
        }
        .navigationTitle("title_devmenu".localized)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.loadData() }
    }
}

struct DeveloperPreview: PreviewProvider {
    static var previews: some View {
        DeveloperView(viewModel: DeveloperViewModel.init(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), storeManager: StoreManager(keychain: KeychainManager(), productsIDs: .init()), keychainManager: KeychainManager()))
    }
}
