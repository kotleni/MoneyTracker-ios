//
//  String.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 23.06.2022.
//

import Foundation

extension String {
    /// Get localized string
    public var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: BundleClass.self), comment: "")
    }
    
    public func localizedWithPlaceholder(arguments: CVarArg...) -> String {
        return String(format: self, arguments)
    }
}

private class BundleClass { }
