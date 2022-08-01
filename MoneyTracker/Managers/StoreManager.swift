//
//  StoreManager.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 28.07.2022.
//

import Foundation
import StoreKit

final class StoreManager: NSObject, ObservableObject {
    var keychain: KeychainManager
    private let productsIdentifiers: Set<String>
    private var productsRequest: SKProductsRequest? = nil
    @Published private(set) var products = [SKProduct]()
    
    private(set) var purchasedProducts: Set<String> = []
    
    public var callbackPurchase: ((Bool) -> Void)?
    
    init(keychain: KeychainManager, productsIDs: Set<String>) {
        self.keychain = keychain
        productsIdentifiers = productsIDs
        // Check if product saved in keychain
        purchasedProducts = Set(productsIdentifiers.filter {
            guard let data = keychain.read(key: $0) else { return false }
            return try! JSONDecoder().decode(Bool.self, from: data)
        })
        super.init()
    }
    
    func requestProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productsIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func buyProduct(product: SKProduct, _ callback: @escaping (Bool) -> Void) {
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
            //Вот тут
            print(response.products)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
