//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

@main
struct MoneyTrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let store: IAPStore
    
    let viewModel = MainViewModel()
    
    init() {
        store = IAPStore(productsIDs: SubscriptionsProducts.subscriptionsID)
        store.requestProducts()
        
        appDelegate.store = store
        viewModel.store = store
    }
    
    var body: some Scene {
        WindowGroup {
            TabsCoordinator(viewModel: viewModel)
                .view()
        }
    }
}
