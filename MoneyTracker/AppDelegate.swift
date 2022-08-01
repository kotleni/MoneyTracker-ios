//
//  AppDelegate.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 22.07.2022.
//

import Foundation
import StoreKit

class AppDelegate: NSObject {
    var store: StoreManager!
    var keychain: KeychainManager!
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SKPaymentQueue.default().add(self)
        return true
    }
}

extension AppDelegate: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                completeTransaction(transaction)
            case .failed:
                failedTransaction(transaction)
            case .purchasing:
                print("(purchasing) being processed")
            case .deferred:
                print("pending external action")
            default:
                print("unhandled transaction state")
            }
        }
    }
    private func completeTransaction(_ transaction: SKPaymentTransaction) {
        defer { SKPaymentQueue.default().finishTransaction(transaction) }
        // Encode BOOL to data type
        let boolData = try! JSONEncoder().encode(true)
        // Save to keychain
        keychain.save(boolData, key: transaction.payment.productIdentifier)
        store.callbackPurchase?(true)
    }
    private func failedTransaction(_ transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError?,
           let errorDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            print("transaction error: \(errorDescription)")
        }
        store.callbackPurchase?(false)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

