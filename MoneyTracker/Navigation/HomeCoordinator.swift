//
//  HomeCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class HomeCoordinator: NavigationCoordinatable {
    // managers
    private let paymentsManager: PaymentsManager
    private let storageManager: StorageManager
    private let notificationsManager: NotificationsManager
    private let tagsManager: TagsManager
    
    // viewModels
    private let homeViewModel: HomeViewModel
    private let addPaymentViewModel: AddPaymentViewModel
    
    var stack = NavigationStack(initial: \HomeCoordinator.main)
    
    init(paymentsManager: PaymentsManager, storageManager: StorageManager, notificationsManager: NotificationsManager, tagsManager: TagsManager) {
        self.paymentsManager = paymentsManager
        self.storageManager = storageManager 
        self.notificationsManager = notificationsManager
        self.tagsManager = tagsManager
        
        // viewModels
        homeViewModel = HomeViewModel(paymentsManager: paymentsManager, storageManager: storageManager, tagsManager: tagsManager)
        addPaymentViewModel = AddPaymentViewModel(paymentsManager: paymentsManager, tagsManager: tagsManager)
    }
    
    @Root var main = makeMain
    @Route(.push) var addPayments = makeAddPayments
    
    @ViewBuilder func makeMain() -> some View {
        HomeView(viewModel: homeViewModel)
    }
    
    @ViewBuilder func makeAddPayments() -> some View {
        AddPaymentView(viewModel: addPaymentViewModel)
    }
}
