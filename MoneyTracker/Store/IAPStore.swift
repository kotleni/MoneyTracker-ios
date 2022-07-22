//
//  IAPStore.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 22.07.2022.
//

import Foundation
import StoreKit

class IAPStore: NSObject, ObservableObject {
    
    private let productsIdentifiers: Set<String>
    private var productsRequest: SKProductsRequest? = nil
    @Published private(set) var products = [SKProduct]()
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
    
    func buyProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension IAPStore: SKProductsRequestDelegate {
    
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

