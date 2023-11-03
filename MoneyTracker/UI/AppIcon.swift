//
//  AppIcon.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 30.08.2022.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
    }
}
