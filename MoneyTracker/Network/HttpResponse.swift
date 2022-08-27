//
//  HttpResponse.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.08.2022.
//

import Foundation

/// Http response
class HttpResponse {
    let isSuccess: Bool             // is response success
    var errorString: String? = nil  // error string (if fail)
    var statusCode: Int? = nil      // http result code
    var data: Data? = nil           // result data
    
    /// Execute errror
    init(isSuccess: Bool, errorString: String) {
        self.isSuccess = isSuccess
        self.errorString = errorString
    }
    
    /// Normal execute
    init(isSuccess: Bool, statusCode: Int, data: Data) {
        self.isSuccess = isSuccess
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
