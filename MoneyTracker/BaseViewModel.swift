//
//  BaseViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import Foundation
import Combine

/// Universal view model protocol
class BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    func loadData() { /* nothing */ }
}
