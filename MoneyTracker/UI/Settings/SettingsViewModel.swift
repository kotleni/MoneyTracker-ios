//
//  SettingsViewModel.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 24.07.2022.
//

import SwiftUI
import Combine

class SettingsViewModel: BaseViewModel {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var currency: String = ""
    @Published private(set) var exportJson: String = ""
    @Published private(set) var isAdError: Bool = false
    @Published private(set) var isAdLoaded: Bool = false
    @Published var isExportJson: Bool = false
    
    /// Load data
    override func loadData() {
        isLoading = true
        currency = storageManager.getPriceType()
        
        PremiumPublisher(storeManager: storeManager)
            .sink { isPremium in
                self.isPremium = isPremium
                self.isLoading = false
            }
            .store(in: &publishers)
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
        
        // for each payments, export and add it to array
        paymentsManager.getPayments().forEach { payment in
            exportablePayments.append(payment.exportPayment())
        }
        
        let exportData = ExportData(appVersion: appVersion, currency: currency, payments: exportablePayments)
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        // try encode json and export
        do {
            let jsonData = try jsonEncoder.encode(exportData)
            let jsonString = String(data: jsonData, encoding: .utf8)
            exportJson = jsonString ?? ""
            isExportJson = true
        } catch let error {
#if DEBUG
            print(error)
#endif
        }
        
        isLoading = false
    }
    
    /// Set ad error
    func setAdError(isError: Bool) {
        self.isAdError = isError
    }
    
    /// Set ad loaded
    func setAdLoaded(isLoaded: Bool) {
        self.isAdLoaded = isLoaded
    }
}
