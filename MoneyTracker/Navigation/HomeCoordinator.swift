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
    private let welcomeViewModel: WelcomeViewModel
    
    var stack = NavigationStack(initial: \HomeCoordinator.main)
    
    init(managersContainer: ManagersContainer) {
        self.managersContainer = managersContainer
        
        // view models
        homeViewModel = .init(managersContainer: managersContainer)
        addPaymentViewModel = .init(managersContainer: managersContainer)
        welcomeViewModel = .init(managersContainer: managersContainer)
    }
    
    @Root var main = makeMain
    @Route(.push) var addPayments = makeAddPayments
    @Route(.modal) var welcome = makeWelcome
    
    @ViewBuilder func makeMain() -> some View {
        HomeView(viewModel: homeViewModel)
    }
    
    @ViewBuilder func makeAddPayments() -> some View {
        AddPaymentView(viewModel: addPaymentViewModel)
    }
    
    @ViewBuilder func makeWelcome() -> some View {
        WelcomeView(viewModel: welcomeViewModel)
    }
}
