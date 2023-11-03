//
//  HttpResponse.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 26.08.2022.
//

import Foundation

/// Http response
class HttpResponse {
    var statusCode: Int? = nil      // http result code
    var data: Data? = nil           // result data
    
    /// Normal execute
    init(statusCode: Int, data: Data) {
        self.statusCode = statusCode
        self.data = data
    }
    
    /// Get string (if data exist)
    func getString() -> String? {
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
