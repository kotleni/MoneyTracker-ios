//
//  SettingsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
//

import SwiftUI
import Combine

class SettingsViewModel: BaseViewModel {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isExperimental: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var currency: String = ""
    @Published private(set) var exportJson: String = ""
    @Published private(set) var isAdError: Bool = false
    @Published private(set) var isAdLoaded: Bool = false
    @Published var isExportJson: Bool = false
    
    /// Load data
    override func loadData() {
        currency = storageManager.getPriceType()
        isExperimental = storageManager.isExperimental()
        
        // Check if product saved in keychain
        if let data = keychainManager.read(key: Static.subsExpirationKeychain),
           let expirationTimeInteval = try? JSONDecoder().decode(TimeInterval.self, from: data) {
            let subscriptionDate = Date(timeIntervalSince1970: expirationTimeInteval)
            isPremium = (Date() <= subscriptionDate)
            print("Settings load premium: \(isPremium)")
        }
    }
    
    /// Set is loading
    func setLoading(isEnabled: Bool) {
        isLoading = isEnabled
    }
    
    /// Export data
    func exportData() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error"
        let currency = storageManager.getPriceType()
        var exportablePayments: [ExportablePayment] = []
        
        paymentsManager.getPayments().forEach { payment in
            exportablePayments.append(payment.exportPayment())
        }
        
        let exportData = ExportData(appVersion: appVersion, currency: currency, payments: exportablePayments)
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(exportData)
            let jsonString = String(data: jsonData, encoding: .utf8)
            exportJson = jsonString ?? ""
            isExportJson = true
        } catch let error {
            print(error)
        }
        
        isLoading = false
    }
    
    /// Set ad loaded
    func setAdError(isError: Bool) {
        self.isAdError = isError
    }
    
    /// Set ad loaded
    func setAdLoaded(isLoaded: Bool) {
        self.isAdLoaded = isLoaded
    }
}
