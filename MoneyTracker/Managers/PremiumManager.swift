//
//  PremiumManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 14.07.2022.
//

import Foundation
import StoreKit

/// Premium subscribe manager
class PremiumManager {
    static let shared = PremiumManager()
    
    /// Check is shop available
    func isAvailable() async -> Bool {
        let products = try! await Product.products(for: ["moneytracker.preimium1"])
        return !(products.isEmpty)
    }
    
    /// Try subscribe to premium
    func trySubscribe() async -> Product.PurchaseResult {
        let products = try! await Product.products(for: ["moneytracker.preimium1"])
        let result = try! await products[0].purchase()
        return result
    }
    
    /// Check is premium subscribed
    func isPremiumExist() async -> Bool {
        let products = try! await Product.products(for: ["moneytracker.preimium1"])
        
        if products.isEmpty {
            return false
        }
        
        let state = try! await products[0].currentEntitlement
        
        switch state {
        case .verified( _):
            print(".verifed")
            return true
        case .unverified( _, _):
            print(".unverified")
            return true
        default:
            return false
        }
    }
    
    /// Get premium price
    func getPremiumPrice() async -> String {
        let products = try! await Product.products(for: ["moneytracker.preimium1"])
        if products.isEmpty {
            return ""
        }
        return products.first!.displayPrice
    }
}
