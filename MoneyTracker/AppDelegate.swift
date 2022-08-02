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
        guard Receipt.isReceiptPresent() else { return }
        let receipt = Receipt()
        if receipt.receiptStatus == .validationSuccess {
            // Work with subscribtion date
            var savedDate: Date!
            for receipt in receipt.inAppReceipts {
                guard let expirationDate = receipt.subscriptionExpirationDate else { return }
                if savedDate == nil || expirationDate > savedDate {
                    savedDate = expirationDate
                }
            }
            // Encode to data type
            guard let data = try? JSONEncoder().encode(savedDate.timeIntervalSince1970) else { return }
            // Save to keychain
            keychain.save(data, key: Static.subsExpirationKeychain)
            store.callbackPurchase?(true)
        } else {
            store.callbackPurchase?(false)
        }
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

