//
//  CurrenciesError.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.08.2022.
//

import Foundation

enum CurrenciesError: LocalizedError {
    case notFounded
    
    var errorDescription: String? {
        switch self {
        case .notFounded:
            return "Currency not founded"
        }
    }
}
