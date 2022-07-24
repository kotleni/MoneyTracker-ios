//
//  SettingsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class SettingsCoordinator: NavigationCoordinatable {
    var viewModel: SettingsViewModel
    var stack = NavigationStack(initial: \SettingsCoordinator.main)
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
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
        SettingsView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeCurrencyEditor() -> some View {
        CurrencyEditorView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeTagsEditor() -> some View {
        TagsEditorView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeAboutApp() -> some View {
        AboutAppView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeDeveloper() -> some View {
        DeveloperView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeResetPayments() -> some View {
        ResetPaymentsView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeNotifications() -> some View {
        NotificationsView(viewModel: viewModel)
    }
    
    @ViewBuilder func makePremium() -> some View {
        PremiumView(viewModel: viewModel)
    }
}
