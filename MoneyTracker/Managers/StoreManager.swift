//
//  StoreManager.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 28.07.2022.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject {
    
    private let productsIdentifiers: Set<String>
    private var productsRequest: SKProductsRequest? = nil
    @Published private(set) var products = [SKProduct]()
    
    public var callbackPurchase: ((Bool) -> Void)?
    
    init(productsIDs: Set<String>) {
        productsIdentifiers = productsIDs
        super.init()
    }
    
    func requestProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productsIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func buyProductMonth(_ callback: @escaping (Bool) -> Void) {
        let sortedProduct = products.sorted { priceFormatter($0) < priceFormatter($1) }
        guard let product = sortedProduct.first else { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        callbackPurchase = { bool in
            callback(bool)
        }
    }
    
    func priceFormatter(_ product: SKProduct) -> String {
        let formatter = NumberFormatter()
        formatter.locale = product.priceLocale
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: product.price) ?? ""
    }
    
    func subscribtionPeriod(_ product: SKProduct) -> String {
        let duration = product.subscriptionPeriod
        switch duration {
        case .none:
            return ""
        case .some(let period):
            return period.localizedPeriod() ?? ""
        }
    }
}

extension StoreManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.products = response.products
            self?.objectWillChange.send()
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
