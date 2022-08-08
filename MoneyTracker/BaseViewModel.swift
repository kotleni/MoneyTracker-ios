//
//  BaseViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import Foundation
import Combine

/// Universal view model base
class BaseViewModel {
    /// All viewmodel publishers
    var publishers: Set<AnyCancellable> = []
    
    /// Loading data
    func loadData() { /* nothing */ }
}
