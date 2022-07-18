//
//  TabsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class TabsCoordinator: TabCoordinatable {
    var viewModel: MainViewModel
    lazy var child = TabChild(startingItems: [
        \TabsCoordinator.home,
        \TabsCoordinator.settings,
    ], activeTab: 0)
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.viewModel.loadAllData()
    }
    
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeSettingsTab) var settings = makeSettings
    
    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator(viewModel: viewModel))
    }
    
    func makeSettings() -> NavigationViewCoordinator<SettingsCoordinator> {
        return NavigationViewCoordinator(SettingsCoordinator(viewModel: viewModel))
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
