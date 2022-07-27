//
//  Payment.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 24.07.2022.
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
        let paymentTag = (self.tag == nil) ? Tag.getDefault().name! : self.tag!
        if filter == paymentTag && self.price < 0 {
            return true
        }
        
        return false
    }
}
