//
//  TabsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class TabsCoordinator: TabCoordinatable {
    // viewmodels
    private let homeViewModel: HomeViewModel
    private let settingsViewModel: SettingsViewModel
    
    lazy var child = TabChild(startingItems: [
        \TabsCoordinator.home,
        //\TabsCoordinator.settings,
    ], activeTab: 0)
    
    init(homeViewModel: HomeViewModel, settingsViewModel: SettingsViewModel) {
        self.homeViewModel = homeViewModel
        self.settingsViewModel = settingsViewModel
    }
    
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeSettingsTab) var settings = makeSettings
    
    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator(viewModel: homeViewModel))
    }
    
    func makeSettings() -> NavigationViewCoordinator<SettingsCoordinator> {
        return NavigationViewCoordinator(SettingsCoordinator(viewModel: settingsViewModel))
    }
    
    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        VStack {
            Image(systemName: "house")
            Text("title_home".localized)
        }
    }
    
    @ViewBuilder func makeSettingsTab(isActive: Bool) -> some View {
        VStack {
            Image(systemName: "gear")
            Text("title_settings".localized)
        }
    }
}
