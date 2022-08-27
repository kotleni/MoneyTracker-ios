//
//  HttpRequest.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.08.2022.
//

import Foundation
import SwiftyJSON

/// Http request
class HttpRequest {
    private var url: String = ""
    private var method: HttpMethod = .GET
    private var body: String = ""
    private var queryItems: [URLQueryItem] = []
    
    /// Set url
    func setUrl(url: String) -> HttpRequest {
        self.url = url
        return self
    }
    
    /// Set http method
    func setMethod(method: HttpMethod) -> HttpRequest {
        self.method = method
        return self
    }
    
    /// Set json body
    func setBody(json: JSON) -> HttpRequest {
        if let body = json.rawString() {
            self.body = body
        }
        return self
    }
    
    /// Set query parameters
    func setParameters(queryItems: [URLQueryItem]) -> HttpRequest {
        self.queryItems = queryItems
        return self
    }
    
    /// Execute reponse
    private func _execute() -> HttpResponse {
        guard var urlComponents = URLComponents(string: url)
        else { return HttpResponse(isSuccess: false, errorString: "[⛔️] Wrong url") }
        urlComponents.queryItems = self.queryItems
        guard let url = urlComponents.url else { return HttpResponse(isSuccess: false, errorString: "[⛔️] Wrong url") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // if body has data
        if !body.isEmpty {
            request.httpBody = body.data(using: .utf8)
        }
        
        let result = URLSession.shared.syncRequest(with: request)
        
        // if result data exist
        if let data = result.0 {
            guard let resp = (result.1 as? HTTPURLResponse) else { return HttpResponse(isSuccess: false, errorString: "[⛔️] Unknown error") }
            let status = resp.statusCode
            return HttpResponse(isSuccess: true, statusCode: status, data: data)
        }
        
        // unknown bahavior
        return HttpResponse(isSuccess: false, errorString: "[⛔️] Unknown error")
    }
    
    /// Execute response and print debug
    func execute() -> HttpResponse {
#if DEBUG
        print("[HttpRequest] \(method.rawValue) \(url) query: \(queryItems), body: '\(body)'")
#endif
        
        // execute
        let response = _execute()
        
#if DEBUG
        if response.isSuccess {
            print("[HttpRequest] Response success: \(String(describing: response.getString()))")
        } else {
            print("[HttpRequest] Reponse fail: \(String(describing: response.errorString))")
        }
#endif
        
        return response
    }
}
