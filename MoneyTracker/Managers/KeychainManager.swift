//
//  KeychainManager.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 01.08.2022.
//

import Foundation

/// Keychain values manager
final class KeychainManager {
    
    /// Save data
    func save(_ data: Data, key: String) {
        let query = [
            kSecValueData: data,
            kSecAttrSynchronizable: true,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        // add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // item already exist, thus update it.
            let query = [
                kSecAttrSynchronizable: true,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    /// Read data
    func read(key: String) -> Data? {
        let query = [
            kSecAttrSynchronizable: true,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(key: String) {
        let query = [
            kSecAttrSynchronizable: true,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
