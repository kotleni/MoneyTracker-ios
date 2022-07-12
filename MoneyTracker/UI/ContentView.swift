//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tag(1)
                .tabItem {
                    Label("Платежи", systemImage: "tray.full")
                }
            SettingsView()
                .tag(2)
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}
