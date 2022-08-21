//
//  HomeCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class HomeCoordinator: NavigationCoordinatable {
    private let managersContainer: ManagersContainer
    
    // viewModels
    private let homeViewModel: HomeViewModel
    private let addPaymentViewModel: AddPaymentViewModel
    
    var stack = NavigationStack(initial: \HomeCoordinator.main)
    
    init(managersContainer: ManagersContainer) {
        self.managersContainer = managersContainer
        
        // viewModels
        homeViewModel = HomeViewModel.init(managersContainer: managersContainer)
        addPaymentViewModel = AddPaymentViewModel.init(managersContainer: managersContainer)
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
