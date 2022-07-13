//
//  HapticManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import UIKit

/// Haptic manager
class HapticManager {
    static let shared = HapticManager()
    
    private let generator = UINotificationFeedbackGenerator()
    
    /// Notify error
    func error() {
        generator.notificationOccurred(.error)
    }
    
    /// Notify success
    func success() {
        generator.notificationOccurred(.success)
    }
    
    /// Notify warning
    func warning() {
        generator.notificationOccurred(.warning)
    }
}
