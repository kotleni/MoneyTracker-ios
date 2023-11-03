//
//  HttpRequest.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 26.08.2022.
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
    private func _execute() throws -> HttpResponse {
        guard var urlComponents = URLComponents(string: url) else { throw NetworkingError.invalidUrl(url) }
        urlComponents.queryItems = self.queryItems
        
        guard let url = urlComponents.url else { throw NetworkingError.invalidUrl(url) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // if body has data
        if !body.isEmpty {
            request.httpBody = body.data(using: .utf8)
        }
        
        let result = URLSession.shared.syncRequest(with: request)
        
        // if result data exist
        if let data = result.0 {
            guard let resp = (result.1 as? HTTPURLResponse) else {  throw NetworkingError.unknown }
            let status = resp.statusCode
            return HttpResponse(statusCode: status, data: data)
        }
        
        throw NetworkingError.unknown
    }
    
    /// Execute response and print debug
    func execute() throws -> HttpResponse {
#if DEBUG
        print("[HttpRequest] \(method.rawValue) \(url) query: \(queryItems), body: '\(body)'")
#endif
        
        // execute
        let response = try _execute()
        
#if DEBUG
        print("[HttpRequest] Response: \(String(describing: response.getString()))")
#endif
        
        return response
    }
}
