//
//  TabsCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class TabsCoordinator: TabCoordinatable {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
    }
    
    lazy var child = TabChild(startingItems: [
        \TabsCoordinator.home,
        \TabsCoordinator.settings,
    ], activeTab: 0)
    
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeSettingsTab) var settings = makeSettings
    
    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager))
    }
    
    func makeSettings() -> NavigationViewCoordinator<SettingsCoordinator> {
        return NavigationViewCoordinator(SettingsCoordinator(paymentsManager: paymentsManager, storageManager: storageManager, notificationsManager: notificationsManager, tagsManager: tagsManager))
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
