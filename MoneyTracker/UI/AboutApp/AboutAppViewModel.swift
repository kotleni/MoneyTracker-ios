//
//  AboutAppViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class AboutAppViewModel: BaseViewModel {
    @Published private(set) var isDeveloper: Bool = false

    /// Load data
    override func loadData() {
        self.isDeveloper = storageManager.isDeveloper()
    }
    
    /// Enable developer
    func enableDeveloper() {
        isDeveloper = true
        storageManager.setDeveloper(isEnable: true)
    }
}
