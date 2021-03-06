//
//  View.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        return conditional ? AnyView(content(self)) : AnyView(self)
    }
}
