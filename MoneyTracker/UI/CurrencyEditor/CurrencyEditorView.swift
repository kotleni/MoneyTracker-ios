//
//  ChangeCurrencyView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct CurrencyEditorView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    @ObservedObject var viewModel: CurrencyEditorViewModel
    
    @State private var filterText: String = ""
    
    var body: some View {
        VStack {
            SearchBarView(text: $filterText, hint: "hint_search".localized)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    // popular
                    if filterText == "" {
                        Section {
                            ForEach(Currencies.currenciesPopular, id: \.self) { curr in
                                if curr.fullName.lowercased().contains(filterText.lowercased()) || curr.littleName.lowercased().contains(filterText.lowercased()) || filterText.isEmpty {
                                    Button {
                                        viewModel.setCurrency(id: curr.id)
                                    } label: {
                                        HStack {
                                            Text(curr.fullName)
                                                .foregroundColor(Color("DefaultText"))
                                            Text(curr.littleName)
                                                .foregroundColor(.gray)
                                            Spacer()
                                            if (viewModel.selectedCurrencyId == curr.id) {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                                    .transition(.opacity)
                                            }
                                        }
                                    }
                                }
                            }
                        } header: {
                            Text("label_popular".localized)
                        }
                    }

                    // all
                    Section {
                        ForEach(Currencies.currenciesAll, id: \.self) { curr in
                            if curr.fullName.lowercased().contains(filterText.lowercased()) || curr.littleName.lowercased().contains(filterText.lowercased()) || filterText.isEmpty {
                                Button(action: {
                                    viewModel.setCurrency(id: curr.id)
                                }, label: {
                                    HStack {
                                        Text(curr.fullName)
                                            .foregroundColor(Color("DefaultText"))
                                        Text(curr.littleName)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        if (viewModel.selectedCurrencyId == curr.id) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                                .transition(.opacity)
                                        }
                                    }
                                })
                            }
                        }
                    } header: {
                        if filterText == "" {
                            Text("label_allcurrencies".localized)
                        } else {
                            Text("")
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("title_selcurrency".localized, displayMode: .inline)
        .onAppear { viewModel.loadData() }
    }
}

struct CurrencyEditorPreview: PreviewProvider {
    static var previews: some View {
        CurrencyEditorView(viewModel: CurrencyEditorViewModel(storageManager: StorageManager()))
    }
}
