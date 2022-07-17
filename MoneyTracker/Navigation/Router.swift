//
//  Router.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import UIKit

protocol Router: ObservableObject {
    var nav: UINavigationController? { get set }
    func pushTo(view: UIViewController)
    func popTo(view: UIViewController)
    func popToRoot()
}

extension Router {
    func popToRoot() {
        nav?.popToRootViewController(animated: true)
    }
}
