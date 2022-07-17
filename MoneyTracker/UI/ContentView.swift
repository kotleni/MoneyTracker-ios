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
        Text("x")
//        MainView(viewModel: viewModel)
//            .onAppear {
//                viewModel.loadAllData()
//            }
//        NavigationView {
//            TabView(selection: $selection) {
//                MainView(viewModel: viewModel)
//                    .tag(0)
//                    .navigationBarHidden(true)
//                    .tabItem {
//                        Label("label_payments".localized, systemImage: "tray.full")
//                    }
//                SettingsView(viewModel: viewModel)
//                    .tag(1)
//                    .navigationBarHidden(true)
//                    //.navigationBarHidden(false)
//                    .tabItem {
//                        Label("label_settings".localized, systemImage: "gear")
//                    }
//            }
//            //.navigationBarTitleDisplayMode(.inline)
//            .navigationTitle(selection == 1 ? "label_settings".localized : "Payments")
//        }
//        .onAppear {
//            viewModel.loadAllData()
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .onAppear {
//            UITabBar.appearance().backgroundColor = UIColor(named: "TabViewColor")
//        }
    }
}
