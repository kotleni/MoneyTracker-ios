//
//  HomeCoordinator.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI
import Stinsen

final class HomeCoordinator: NavigationCoordinatable {
    var viewModel: MainViewModel
    var stack = NavigationStack(initial: \HomeCoordinator.main)
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    @Root var main = makeMain
    
    @ViewBuilder func makeMain() -> some View {
        HomeView(viewModel: viewModel)
    }
}
