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
    
    private var settingsViewModel: SettingsViewModel {
        return SettingsViewModel.init(managersContainer: managersContainer)
    }
    private var currencyEditorViewModel: CurrencyEditorViewModel {
        return CurrencyEditorViewModel.init(managersContainer: managersContainer)
    }
    private var tagsEditorViewModel: TagsEditorViewModel {
        return TagsEditorViewModel.init(managersContainer: managersContainer)
    }
    private var aboutAppViewModel: AboutAppViewModel {
        return AboutAppViewModel.init(managersContainer: managersContainer)
    }
    private var developerViewModel: DeveloperViewModel {
        return DeveloperViewModel.init(managersContainer: managersContainer)
    }
    private var resetPaymentsViewModel: ResetPaymentsViewModel {
        return ResetPaymentsViewModel.init(managersContainer: managersContainer)
    }
    private var notificationsViewModel: NotificationsViewModel {
        return NotificationsViewModel.init(managersContainer: managersContainer)
    }
    private var premiumViewModel: PremiumViewModel {
        return PremiumViewModel.init(managersContainer: managersContainer)
    }
    
    var stack = NavigationStack(initial: \SettingsCoordinator.main)
    
    init(managersContainer: ManagersContainer) {
        self.managersContainer = managersContainer
    }
    
    @Root var main = makeMain
    @Route(.push) var currencyEditor = makeCurrencyEditor
    @Route(.push) var tagsEditor = makeTagsEditor
    @Route(.push) var aboutApp = makeAboutApp
    @Route(.modal) var developer = makeDeveloper
    @Route(.push) var resetPayments = makeResetPayments
    @Route(.push) var notifications = makeNotifications
    @Route(.modal) var premium = makePremium
    
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
