//
//  PremiumViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class PremiumViewModel: BaseViewModel {
    @Published private(set) var isShopAvailable: Bool = false
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var premiumPrice: String = ""
    
    /// Load all
    override func loadData() {
        if let product = storeManager.products.first {
            premiumPrice = storeManager.priceFormatter(product)
            isShopAvailable = true
        }
        if let subscriptionExpireDate = storeManager.subscriptionDate {
            if Date() >= subscriptionExpireDate {
                print("Подписка истекла")
                isPremium = false
            } else {
                print("Подписка активна")
                isPremium = true
            }
        }
    }
    
    /// Try purshace premium
    func purshacePremium(onEnd: @escaping (_ isSuccess: Bool) -> Void) {
        // Потом нужно будет переписать, если будет больше одной покупки,
        // сейчас покупается самая дешевая покупка))
        let sortedProduct = storeManager.products.sorted { storeManager.priceFormatter($0) < storeManager.priceFormatter($1) }
        guard let product = sortedProduct.first else { return }
        
        print("buyproduct")
        storeManager.buyProduct(product: product) { isSuccess in
            self.isPremium = isSuccess
            print(isSuccess)
            onEnd(isSuccess)
        }
    }
}
