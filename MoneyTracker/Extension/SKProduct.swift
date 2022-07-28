//
//  SKProduct.swift
//  MoneyTracker
//
//  Created by Mark Khmelnitskii on 28.07.2022.
//

import StoreKit

extension SKProduct.PeriodUnit {
    func toCalendarUnit() -> NSCalendar.Unit {
        switch self {
        case .day:
            return .day
        case .month:
            return .month
        case .week:
            return .weekOfMonth
        case .year:
            return .year
        @unknown default:
            debugPrint("Unknown period unit")
        }
        return .day
    }
    
    func toNumberOfMonth() -> Int? {
        switch self {
        case .day: return 0
        case .week: return 0
        case .month: return 1
        case .year: return 12
        @unknown default:
            debugPrint("Unknown period unit")
            return 0
        }
    }
}

extension SKProductSubscriptionPeriod {
    private var componentFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }
    private func format(unit: NSCalendar.Unit, numberOfUnits: Int) -> String? {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        componentFormatter.allowedUnits = [unit]
        switch unit {
        case .day:
            dateComponents.setValue(numberOfUnits, for: .day)
        case .weekOfMonth:
            dateComponents.setValue(numberOfUnits, for: .weekOfMonth)
        case .month:
            dateComponents.setValue(numberOfUnits, for: .month)
        case .year:
            dateComponents.setValue(numberOfUnits, for: .year)
        default:
            return nil
        }
        return componentFormatter.string(from: dateComponents)
    }
    func localizedPeriod() -> String? {
        return format(unit: unit.toCalendarUnit(), numberOfUnits: numberOfUnits)
    }
}
