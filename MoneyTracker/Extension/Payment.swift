//
//  Payment.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 24.07.2022.
//

import Foundation

extension Payment {
    /// Check filter for payment
    func isFilterOk(filter: String) -> Bool {
        // is all
        if filter == "filter_all" {
            return true
        }
        
        // is selected tag
        if let tag = self.tag {
            if filter == tag && self.price < 0 {
                return true
            }
        }
        
        return false
    }
    
    /// Make exportable payment
    func exportPayment() -> ExportablePayment {
        return ExportablePayment(date: (self.date ?? Date()).getDateTimeString(), about: self.about ?? "", price: self.price, tag: self.tag ?? "")
    }
}
