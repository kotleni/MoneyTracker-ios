//
//  HttpResponse.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.08.2022.
//

import Foundation

class HttpResponse {
    let isSuccess: Bool
    var errorString: String? = nil
    var statusCode: Int? = nil
    var data: Data? = nil
    
    init(isSuccess: Bool, errorString: String) {
        self.isSuccess = isSuccess
        self.errorString = errorString
    }
    
    init(isSuccess: Bool, statusCode: Int, data: Data) {
        self.isSuccess = isSuccess
        self.statusCode = statusCode
        self.data = data
    }
    
    func getString() -> String? {
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
