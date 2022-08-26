//
//  URLSession.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.08.2022.
//

import Foundation

extension URLSession {
    func syncRequest(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
        
        return (data, response, error)
    }
    
    func syncRequest(with urlComponents: URLComponents) -> (Data?, URLResponse?, Error?) {
        guard let url = urlComponents.url else { return (nil, nil, nil) }
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
        
        return (data, response, error)
    }
    
    func syncRequest(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
        
        return (data, response, error)
    }
}
