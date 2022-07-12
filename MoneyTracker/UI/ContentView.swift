//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                MainView()
                    .tag(0)
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("Платежи", systemImage: "tray.full")
                    }
                SettingsView()
                    .tag(1)
                    .tabItem {
                        Label("Настройки", systemImage: "gear")
                    }
            }
            .navigationTitle(selection == 1 ? "Настройки" : "--")
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}
