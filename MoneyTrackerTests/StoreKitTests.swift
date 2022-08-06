//
//  StoreKitTests.swift
//  MoneyTrackerTests
//
//  Created by Mark Khmelnitskii on 01.08.2022.
//

import XCTest
import StoreKitTest
@testable import MoneyTracker

class StoreKitTests: XCTestCase {
    
    var products = [SKProduct]()
    var keychain = KeychainManager()
    
    override func setUpWithError() throws {
        if products.count > 0 {
            return
        }
    
        let store = StoreManager(keychain: keychain, productsIDs: Static.subscriptionsID)
        
        store.requestProducts()
        let loadProductsExpectation = expectation(description: "load products")
        
        let result = XCTWaiter.wait(for: [loadProductsExpectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            products = store.products
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testKeychain() {
        let key = "TestingKey"
        
        keychain.delete(key: key)
        XCTAssertNil(keychain.read(key: key))
        
        let data = try! JSONEncoder().encode(true)
        keychain.save(data, key: key)
        
        let dataNew = keychain.read(key: key)
        let boolValue = try? JSONDecoder().decode(Bool.self, from: dataNew ?? Data())
        XCTAssertNotNil(boolValue)
        XCTAssertTrue(boolValue!)
    }
    
    func testBuyProduct() {
        let product = products.first!
        
        keychain.delete(key: product.productIdentifier)
        XCTAssertNil(keychain.read(key: product.productIdentifier))
        
        let store = StoreManager(keychain: keychain, productsIDs: Static.subscriptionsID)
        store.buyProduct(product: product) { result in
            let data = self.keychain.read(key: product.productIdentifier)
            XCTAssertNotNil(data)
            let isOwned = try? JSONDecoder().decode(Bool.self, from: data!)
            XCTAssertNotNil(isOwned)
            XCTAssertTrue(result)
        }
    }
}
