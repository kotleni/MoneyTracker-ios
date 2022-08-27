//
//  AppDelegate.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 22.07.2022.
//

import Foundation
import StoreKit
import GoogleMobileAds

class AppDelegate: NSObject {
    var store: StoreManager!
    var keychainManager: KeychainManager!
}

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        SKPaymentQueue.default().add(self)
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
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
#if DEBUG
                print("(purchasing) being processed")
#endif
            case .deferred:
#if DEBUG
                print("pending external action")
#endif
            default:
#if DEBUG
                print("unhandled transaction state")
#endif
            }
        }
    }
    
    private func completeTransaction(_ transaction: SKPaymentTransaction) {
        defer { SKPaymentQueue.default().finishTransaction(transaction) }
        guard Receipt.isReceiptPresent() else { return }
        let receipt = Receipt()
        if receipt.receiptStatus == .validationSuccess {
            // work with subscribtion date
            var savedDate: Date!
            for receipt in receipt.inAppReceipts {
                guard let expirationDate = receipt.subscriptionExpirationDate else { return }
                if savedDate == nil || expirationDate > savedDate {
                    savedDate = expirationDate
                }
            }
            // encode to data type
            guard let data = try? JSONEncoder().encode(savedDate.timeIntervalSince1970) else { return }
            // save to keychain
            keychainManager.save(data, key: Static.subsExpirationKeychain)
            store.callbackPurchase?(true)
        } else {
            store.callbackPurchase?(false)
        }
    }
    
    private func failedTransaction(_ transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError?,
           let errorDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
#if DEBUG
            print("transaction error: \(errorDescription)")
#endif
        }
        store.callbackPurchase?(false)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}
