//
//  NetworkingError.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 27.08.2022.
//

import Foundation

enum NetworkingError: LocalizedError {
    case unknown
    case invalidUrl(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl(let url):
            return "networkingerror_invalidurl".localizedWithPlaceholder(arguments: url)
        case .unknown:
            return "networkingerror_unknown".localized
        }
    }
}
