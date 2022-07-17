//
//  Date.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: date)
    }
}
