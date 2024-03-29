//
//  ExportData.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 20.08.2022.
//

import Foundation

/// Exportable data
struct ExportData: Codable {
    let appVersion: String
    let currency: String
    let payments: [ExportablePayment]
}
