//
//  CheckoutNavigation.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import UIKit
import SwiftUI

final class CheckoutView: ViewBuilder {
    
    static let builder = CheckoutView()
    
    private init() {}
    
    func makeView<T: View>(_ view: T, withNavigationTitle title: String) -> UIViewController {
        CustomHostingController(rootView: view, navigationBarTitle: title, navigationBarHidden: false)
    }
}

final class CheckoutViewsRouter: Router {
    var nav: UINavigationController?
    
    func pushTo(view: UIViewController) {
        nav?.pushViewController(view, animated: true)
    }
    
    func popTo(view: UIViewController) {
        nav?.popToViewController(view, animated: true)
    }
}
