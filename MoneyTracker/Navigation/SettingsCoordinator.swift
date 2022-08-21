//
//  SettingsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class SettingsCoordinator: NavigationCoordinatable {
    private let managersContainer: ManagersContainer
    
    private let settingsViewModel: SettingsViewModel
    private let currencyEditorViewModel: CurrencyEditorViewModel
    private let tagsEditorViewModel: TagsEditorViewModel
    private let aboutAppViewModel: AboutAppViewModel
    private let developerViewModel: DeveloperViewModel
    private let resetPaymentsViewModel: ResetPaymentsViewModel
    private let notificationsViewModel: NotificationsViewModel
    private let premiumViewModel: PremiumViewModel
    
    var stack = NavigationStack(initial: \SettingsCoordinator.main)
    
    init(managersContainer: ManagersContainer) {
        self.managersContainer = managersContainer
        
        // viewModels
        settingsViewModel = SettingsViewModel.init(managersContainer: managersContainer)
        currencyEditorViewModel = CurrencyEditorViewModel.init(managersContainer: managersContainer)
        tagsEditorViewModel = TagsEditorViewModel.init(managersContainer: managersContainer)
        aboutAppViewModel = AboutAppViewModel.init(managersContainer: managersContainer)
        developerViewModel = DeveloperViewModel.init(managersContainer: managersContainer)
        resetPaymentsViewModel = ResetPaymentsViewModel.init(managersContainer: managersContainer)
        notificationsViewModel = NotificationsViewModel.init(managersContainer: managersContainer)
        premiumViewModel = PremiumViewModel.init(managersContainer: managersContainer)
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
