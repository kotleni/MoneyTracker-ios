//
//  DeviceSupportHelper.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 17.08.2022.
//

import Foundation
import SwiftUI

/// Device support helper
class DeviceSupportHelper {
    private static let interfaceIdiom = UIDevice.current.userInterfaceIdiom
    
    /// Check is iPad
    static func isPad() -> Bool {
        return interfaceIdiom == .pad
    }
    
    /// Check is iPhone
    static func isPhone() -> Bool {
        return interfaceIdiom == .phone
    }
}
