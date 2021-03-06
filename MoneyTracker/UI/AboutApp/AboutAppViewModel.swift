//
//  AboutAppViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class AboutAppViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    private let storageManager: StorageManager
    
    @Published private(set) var isDeveloper: Bool = false
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

    /// Load data
    func loadData() {
        self.isDeveloper = storageManager.isDeveloper()
    }
    
    /// Enable developer
    func enableDeveloper() {
        isDeveloper = true
        storageManager.setDeveloper(isEnable: true)
    }
}
