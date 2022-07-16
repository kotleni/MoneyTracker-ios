//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: MainViewModel = MainViewModel()
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                MainView(viewModel: viewModel)
                    .tag(0)
                    .navigationBarHidden(true)
                    .tabItem {
                        Label("label_payments".localized, systemImage: "tray.full")
                    }
                SettingsView(viewModel: viewModel)
                    .tag(1)
                    .tabItem {
                        Label("label_settings".localized, systemImage: "gear")
                    }
            }
            .navigationTitle(selection == 1 ? "label_settings".localized : "")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(named: "TabViewColor")
        }
    }
}
