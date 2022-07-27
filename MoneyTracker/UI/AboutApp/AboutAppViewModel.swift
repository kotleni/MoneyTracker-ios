//
//  AboutAppViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI

class AboutAppViewModel: ObservableObject, BaseViewModel {
    private let storageManager: StorageManager
    
    @Published private(set) var isDeveloper: Bool = false
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

    /// Load data
    func loadData() {
        isDeveloper = storageManager.isDeveloper()
    }
    
    /// Enable developer
    func enableDeveloper() {
        isDeveloper = true
        storageManager.setDeveloper(isDeveloper: true)
    }
}