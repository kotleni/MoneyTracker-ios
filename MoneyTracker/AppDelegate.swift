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
        //NotificationCenter.default.post(name: NSNotification.Name("purchasedSuccess"), object: nil, userInfo: ["transactionID": transaction.transactionIdentifier!])
        store.callbackPurchase?(true)
    }
    private func failedTransaction(_ transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError?,
           let errorDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            print("transaction error: \(errorDescription)")
        }
        store.callbackPurchase?(false)
        //NotificationCenter.default.post(name: NSNotification.Name("purchasedFailed"), object: nil)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

