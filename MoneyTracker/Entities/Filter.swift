//
//  Filter.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import Foundation

/// Filter for payments list
enum Filter: String, CaseIterable, Identifiable {
    case all = "filter_all"
    case plus = "filter_plus"
    
    var id: Self { self }
}
