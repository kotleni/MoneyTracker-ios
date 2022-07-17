//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

@main
struct MoneyTrackerApp: App {
    let nav = NavigationControllers()
    let router = CheckoutViewsRouter()
    let viewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootNavigationController(nav: nav.checkoutNavigationController, rootView: MainView(viewModel: viewModel), navigationBarTitle: "MoneyTracker")
                            .environmentObject(router)
                            .onAppear {
                                router.nav = nav.checkoutNavigationController
                                viewModel.loadAllData()
                            }
        }
    }
}

extension UINavigationController: ObservableObject {}
