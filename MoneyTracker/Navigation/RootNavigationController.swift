//
//  RootNavigationController.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import SwiftUI

// reusable Navigation Controller to be used as the root controller
struct RootNavigationController<RootView: View>: UIViewControllerRepresentable {
    let nav: UINavigationController
    let rootView: RootView
    let navigationBarTitle: String
    let navigationBarHidden: Bool
    
    init(nav: UINavigationController, rootView: RootView, navigationBarTitle: String, navigationBarHidden: Bool = false) {
        self.nav = nav
        self.rootView = rootView
        self.navigationBarTitle = navigationBarTitle
        self.navigationBarHidden = navigationBarHidden
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let vc = CustomHostingController(rootView: rootView, navigationBarTitle: navigationBarTitle, navigationBarHidden: navigationBarHidden)
        nav.addChild(vc)
        return nav
    }

    func updateUIViewController(_ pageViewController: UINavigationController, context: Context) { }
}
