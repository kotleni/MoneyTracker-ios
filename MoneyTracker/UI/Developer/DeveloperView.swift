//
//  DevMenuView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 16.07.2022.
//

import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: DeveloperViewModel
    
    var body: some View {
        Form {
            Section {
                Button { viewModel.addSpecialPayments() }
                    label: { Text("Add payments for screenshot") }
                Button { viewModel.removeAllPayments() }
                    label: { Text("Remove all payments") }
            } header: {
                Text("Experimental")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("title_devmenu".localized)
        .onAppear { viewModel.loadData() }
    }
}

struct DeveloperPreview: PreviewProvider {
    static var previews: some View {
        DeveloperView(viewModel: DeveloperViewModel.init(managersContainer: .getForPreview()))
    }
}
