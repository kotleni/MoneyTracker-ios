//
//  HapticManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private let generator = UINotificationFeedbackGenerator()
    
    func error() {
        generator.notificationOccurred(.error)
    }
    
    func success() {
        generator.notificationOccurred(.success)
    }
    
    func warning() {
        generator.notificationOccurred(.warning)
    }
}
