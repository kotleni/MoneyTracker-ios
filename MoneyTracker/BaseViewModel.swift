//
//  BaseViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import Foundation
import Combine

protocol BaseViewModel {
    var publishers: Set<AnyCancellable> { get set }
    func loadData()
}
