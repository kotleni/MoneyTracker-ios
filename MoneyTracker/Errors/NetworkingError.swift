//
//  NetworkingError.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.08.2022.
//

import Foundation

enum NetworkingError: LocalizedError {
    case unknown
    case invalidUrl(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl(let url):
            return "Invalid url \(url)"
        case .unknown:
            return "Unknown error"
        }
    }
}
