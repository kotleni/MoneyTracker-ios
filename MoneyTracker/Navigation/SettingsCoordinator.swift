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
    
    private let settingsViewModel: SettingsViewModel
    private let currencyEditorViewModel: CurrencyEditorViewModel
    private let tagsEditorViewModel: TagsEditorViewModel
    private let aboutAppViewModel: AboutAppViewModel
    private let developerViewModel: DeveloperViewModel
    private let resetPaymentsViewModel: ResetPaymentsViewModel
    private let notificationsViewModel: NotificationsViewModel
    private let premiumViewModel: PremiumViewModel
    
    var stack = NavigationStack(initial: \SettingsCoordinator.main)
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        
        // viewModels
        settingsViewModel = SettingsViewModel(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager)
        currencyEditorViewModel = CurrencyEditorViewModel(storageManager: storageManager)
        tagsEditorViewModel = TagsEditorViewModel(tagsManager: tagsManager)
        aboutAppViewModel = AboutAppViewModel(storageManager: storageManager)
        developerViewModel = DeveloperViewModel(storageManager: storageManager, tagsManager: tagsManager, paymentsManager: paymentsManager, notificationsManager: notificationsManager)
        resetPaymentsViewModel = ResetPaymentsViewModel(paymentsManager: paymentsManager)
        notificationsViewModel = NotificationsViewModel(notificationsManager: notificationsManager, storageManager: storageManager)
        premiumViewModel = PremiumViewModel(storageManager: storageManager)
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
