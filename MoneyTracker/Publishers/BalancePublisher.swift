//
//  BalancePublisher.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import Combine

/// Publisher for calculationg balance
struct BalancePublisher: Publisher {
    typealias Output = Balance
    typealias Failure = Never
    
    let payments: [Payment]
    
    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Balance == S.Input {
        let balance = calculateBalance(payments: payments)
        _ = subscriber.receive(balance)
    }
    
    /// Calculate balance by payments array
    private func calculateBalance(payments: [Payment]) -> Balance {
        var income: Float = 0
        var outcome: Float = 0
        
        // summary all payments price
        payments.forEach { payment in
            if payment.price > 0 { // is income
                income += payment.price
            } else if payment.price < 0 { // is outcome
                outcome += payment.price
            }
        }
        
        return Balance(current: income + outcome, income: income, outcome: outcome)
    }
}
