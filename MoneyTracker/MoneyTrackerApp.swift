//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

@main
struct MoneyTrackerApp: App {
    let viewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(viewModel: viewModel)
                .view()
        }
    }
}
