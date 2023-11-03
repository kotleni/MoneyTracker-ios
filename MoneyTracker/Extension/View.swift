//
//  View.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 27.07.2022.
//

import SwiftUI

extension View {
    /// If condition as SUI view moditifier
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        return conditional ? AnyView(content(self)) : AnyView(self)
    }
}
