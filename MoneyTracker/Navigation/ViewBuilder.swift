//
//  ViewBuilder.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import SwiftUI

protocol ViewBuilder {
    func makeView<T: View>(_ view: T, withNavigationTitle title: String) -> UIViewController
}
