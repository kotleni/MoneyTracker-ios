//
//  PaymentsPublisher.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 27.07.2022.
//

import Combine

/// Publisher for loading payments
struct PaymentsPublisher: Publisher {
    typealias Output = [Payment]
    typealias Failure = Never
    
    let paymentsManager: PaymentsManager
    
    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, [Payment] == S.Input {
        let payments = paymentsManager.getPayments()
        _ = subscriber.receive(payments)
    }
}
