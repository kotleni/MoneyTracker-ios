//
//  Filter.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import Foundation

enum Filter: String, CaseIterable, Identifiable {
    case all, minus, plus
    var id: Self { self }
}
