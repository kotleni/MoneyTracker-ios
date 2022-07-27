//
//  BalancePublisher.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import Combine

struct BalancePublisher: Publisher {
    typealias Output = Balance
    typealias Failure = Never
    
    let payments: [Payment]
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Balance == S.Input {
        let balance = calculateBalance(payments: payments)
        let _ = subscriber.receive(balance)
    }
    
    private func calculateBalance(payments: [Payment]) -> Balance {
        var _income: Float = 0
        var _outcome: Float = 0
        payments.forEach { payment in
            if payment.price > 0 { // is income
                _income += payment.price
            } else if payment.price < 0 { // is outcome
                _outcome += payment.price
            }
        }
        
        return Balance(current: _income + _outcome, income: _income, outcome: _outcome)
    }
}
