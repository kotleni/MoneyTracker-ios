//
//  TabsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class TabsCoordinator: TabCoordinatable {
    private let managersContainer: ManagersContainer
    
    init(managersContainer: ManagersContainer) {
        self.managersContainer = managersContainer
    }
    
    lazy var child = TabChild(startingItems: [
        \TabsCoordinator.home,      // home
        \TabsCoordinator.settings   // settings
    ], activeTab: 0)
    
    // routes
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeSettingsTab) var settings = makeSettings
    
    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator(managersContainer: managersContainer))
    }
    
    func makeSettings() -> NavigationViewCoordinator<SettingsCoordinator> {
        return NavigationViewCoordinator(SettingsCoordinator(managersContainer: managersContainer))
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
