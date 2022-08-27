//
//  static.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import Foundation

/// Static app data class
final class Static {
    // links
    static let appstoreUrl = "https://apps.apple.com/ua/app/moneytracker/id1631794003"
    static let githubUrl = "https://github.com/kotleni/MoneyTracker-ios/"
    static let policyUrl = "http://kotleni.github.io/money%20tracker/policy.html"
    static let termsUrl = "http://kotleni.github.io/money%20tracker/terms.html"
    
    // developers list
    static let developers: [Developer] = [
        Developer(name: "Victor Varenik", about: "label_developermain".localized, url: "https://github.com/kotleni"),
        Developer(name: "Mark Hmelnitsky", about: "label_developercontr".localized, url: "https://github.com/openmetrue")
    ]
    
    // subs
    static let subscriptionsID: Set<String> = ["moneytracker.premiumEveryMonth"]
    static let subsExpirationKeychain = "SubscriptionExpirationDate"
    
    // ads
    static let adUnitID = "ca-app-pub-8334416213766495/4179109818" // test: "ca-app-pub-3940256099942544/2934735716"
}
