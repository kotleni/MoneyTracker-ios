//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import UIKit
import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: DeveloperViewModel
    
    var body: some View {
        Form {
            Section {
                Button {
                    viewModel.addRandomPayment()
                } label: {
                    Text("Add payment")
                }
                Toggle(isOn: $viewModel.isExperimental, label: { Text("Experimental features") })
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
