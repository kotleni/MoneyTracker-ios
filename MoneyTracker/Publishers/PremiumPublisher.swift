//
//  PremiumPublisher.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 22.08.2022.
//

import Combine
import SwiftUI

/// Publisher for loading tags
struct PremiumPublisher: Publisher {
    typealias Output = Bool
    typealias Failure = Never
        
    let keychainManager: KeychainManager
    
    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Bool == S.Input {
        checkPremium(subscriber: subscriber)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            checkPremium(subscriber: subscriber)
        }
    }
    
    /// Check if product saved in keychain
    private func checkPremium<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Bool == S.Input {
        if let data = keychainManager.read(key: Static.subsExpirationKeychain),
           let expirationTimeInteval = try? JSONDecoder().decode(TimeInterval.self, from: data) {
            let subscriptionDate = Date(timeIntervalSince1970: expirationTimeInteval)
            let isPremium = (Date() <= subscriptionDate)
            _ = subscriber.receive(isPremium)
        }
    }
}
