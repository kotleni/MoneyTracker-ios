//
//  StoreManager.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 28.07.2022.
//

import Foundation
import StoreKit
import Combine
import SwiftUI

/// Store purchases manager
final class StoreManager: NSObject, ObservableObject {
    var keychainManager: KeychainManager
    private let productsIdentifiers: Set<String>
    private var productsRequest: SKProductsRequest?
    @Published private(set) var products = [SKProduct]()
    
    private(set) var subscriptionDate: Date?
    
    public var callbackPurchase: ((Bool) -> Void)?
    
    init(keychain: KeychainManager, productsIDs: Set<String>) {
        self.keychainManager = keychain
        productsIdentifiers = productsIDs
        
        // check if product saved in keychain
        if let data = keychain.read(key: Static.subsExpirationKeychain),
           let expirationTimeInteval = try? JSONDecoder().decode(TimeInterval.self, from: data) {
            subscriptionDate = Date(timeIntervalSince1970: expirationTimeInteval)
#if DEBUG
            print("Subscription expires: \(String(describing: subscriptionDate))")
            print("Current date: \(String(describing: Date()))")
#endif
        }
        
        super.init()
    }
    
    /// Request all available products
    func requestProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productsIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    /// Try buy product
    func buyProduct(product: SKProduct, _ callback: @escaping (Bool) -> Void) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        callbackPurchase = { isPurchased in
            callback(isPurchased)
        }
    }
    
    /// Formate price
    func priceFormatter(_ product: SKProduct) -> String {
        let formatter = NumberFormatter()
        formatter.locale = product.priceLocale
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: product.price) ?? ""
    }
    
    // MARK: currently not used, but in the future if there are several
    // MARK: subscriptions or you need to display the duration of the subscription - see here.
    /// Get subscribe period string
    func subscribtionPeriod(_ product: SKProduct) -> String {
        let duration = product.subscriptionPeriod
        switch duration {
        case .none:
            return ""
        case .some(let period):
            return period.localizedPeriod() ?? ""
        }
    }
    
    func isSubscribed() -> Bool {
        // check is subscription date >= currenct date
        if let data = keychainManager.read(key: Static.subsExpirationKeychain),
           let expirationTimeInteval = try? JSONDecoder().decode(TimeInterval.self, from: data) {
            let subscriptionDate = Date(timeIntervalSince1970: expirationTimeInteval)
            let isPremium = (Date() <= subscriptionDate)
            return isPremium
        } else { // if don't has stored data in keychain
            return false
        }
    }
}

extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.products = response.products
            self?.objectWillChange.send()
            
#if DEBUG
            print(response.products)
#endif
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
#if DEBUG
        print(error.localizedDescription)
#endif
    }
}
