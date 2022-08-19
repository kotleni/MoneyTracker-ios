//
//  ExportablePayment.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 19.08.2022.
//

import Foundation

struct ExportablePayment: Codable {
    var date: Date
    var about: String
    var price: Float
    var tag: String
}
