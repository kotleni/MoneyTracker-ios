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
    
    private let productId = "moneytracker.preimium1";
    
    /// Check is shop available
    func isAvailable() async -> Bool {
        do {
            let products = try await Product.products(for: [productId])
            return !(products.isEmpty)
        } catch let error { print(error.localizedDescription) }
        
        return false
    }
    
    /// Try subscribe to premium
    func trySubscribe() async -> Product.PurchaseResult? {
        do {
            let products = try await Product.products(for: [productId])
            let result = try await products[0].purchase()
            return result
        } catch let error { print(error.localizedDescription) }
        
        return nil
    }
    
    /// Check is premium subscribed
    func isPremiumExist() async -> Bool {
        do {
            let products = try await Product.products(for: [productId])
            let state = await products[0].currentEntitlement
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
        } catch let error { print(error.localizedDescription) }
        
        return false
    }
    
    /// Get premium price
    func getPremiumPrice() async -> String {
        do {
            let products = try await Product.products(for: [productId])
            return products.first!.displayPrice
        } catch let error { print(error.localizedDescription) }
        
        return ""
    }
}
