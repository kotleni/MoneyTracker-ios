//
//  Date.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.07.2022.
//

import Foundation

extension Date {
    /// Get date string
    func getDateString() -> String {
        let date = self
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: date)
    }
    
    /// Get date+time string
    func getDateTimeString() -> String {
        let date = self
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy hh:mm:ss"
        return df.string(from: date)
    }
}
