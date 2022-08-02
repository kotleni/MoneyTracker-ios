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
    
    func getTimeString() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "hh:MM"
        return df.string(from: date)
    }
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC)
        else { return Date() }
        return localDate
    }
}
