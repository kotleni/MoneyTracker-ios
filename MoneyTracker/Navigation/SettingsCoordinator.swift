//
//  SettingsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class SettingsCoordinator: NavigationCoordinatable {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    private let storeManager: StoreManager
    private let keychainManager: KeychainManager
    
    private let settingsViewModel: SettingsViewModel
    private let currencyEditorViewModel: CurrencyEditorViewModel
    private let tagsEditorViewModel: TagsEditorViewModel
    private let aboutAppViewModel: AboutAppViewModel
    private let developerViewModel: DeveloperViewModel
    private let resetPaymentsViewModel: ResetPaymentsViewModel
    private let notificationsViewModel: NotificationsViewModel
    private let premiumViewModel: PremiumViewModel
    
    var stack = NavigationStack(initial: \SettingsCoordinator.main)
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager, storeManager: StoreManager, keychainManager: KeychainManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        self.storeManager = storeManager
        self.keychainManager = keychainManager
        
        // MARK: fixme, stupid many initializaions
        // viewModels
        settingsViewModel = SettingsViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        currencyEditorViewModel = CurrencyEditorViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        tagsEditorViewModel = TagsEditorViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        aboutAppViewModel = AboutAppViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        developerViewModel = DeveloperViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        resetPaymentsViewModel = ResetPaymentsViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        notificationsViewModel = NotificationsViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
        premiumViewModel = PremiumViewModel.init(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager, storeManager: storeManager, keychainManager: keychainManager)
    }
    
    @Root var main = makeMain
    @Route(.push) var currencyEditor = makeCurrencyEditor
    @Route(.push) var tagsEditor = makeTagsEditor
    @Route(.push) var aboutApp = makeAboutApp
    @Route(.push) var developer = makeDeveloper
    @Route(.push) var resetPayments = makeResetPayments
    @Route(.push) var notifications = makeNotifications
    @Route(.push) var premium = makePremium
    
    @ViewBuilder func makeMain() -> some View {
        SettingsView(viewModel: settingsViewModel)
    }
    
    @ViewBuilder func makeCurrencyEditor() -> some View {
        CurrencyEditorView(viewModel: currencyEditorViewModel)
    }
    
    @ViewBuilder func makeTagsEditor() -> some View {
        TagsEditorView(viewModel: tagsEditorViewModel)
    }
    
    @ViewBuilder func makeAboutApp() -> some View {
        AboutAppView(viewModel: aboutAppViewModel)
    }
    
    @ViewBuilder func makeDeveloper() -> some View {
        DeveloperView(viewModel: developerViewModel)
    }
    
    @ViewBuilder func makeResetPayments() -> some View {
        ResetPaymentsView(viewModel: resetPaymentsViewModel)
    }
    
    @ViewBuilder func makeNotifications() -> some View {
        NotificationsView(viewModel: notificationsViewModel)
    }
    
    @ViewBuilder func makePremium() -> some View {
        PremiumView(viewModel: premiumViewModel)
    }
}
