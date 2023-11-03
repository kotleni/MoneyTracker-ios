//
//  ExportablePayment.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 19.08.2022.
//

import Foundation

struct ExportablePayment: Codable {
    var date: String
    var about: String
    var price: Float
    var tag: String
}
