//
//  NotificationsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isShowToast: Bool = false
    @State private var toastText: String = ""
    
    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            VStack {
                Form {
                    Section {
                        Toggle("label_notifications".localized, isOn: $viewModel.isNotifOn)
                            .onChange(of: viewModel.isNotifOn) { value in
                                viewModel.setNotifications(state: viewModel.isNotifOn)
                                
                                if viewModel.isNotifOn {
                                    NotificationsManager.shared.requestPermission { isSuccess in
                                        if isSuccess {
                                            NotificationsManager.shared.stop()
                                            NotificationsManager.shared.start(
                                                title: "notif_title".localized,
                                                body: "notif_body".localized,
                                                hour: 19,
                                                minute: 00
                                            )
                                        } else {
//                                            toastText = "Уведомления для этого приложения заблокированы"
//                                            isShowToast = true
                                            viewModel.setNotifications(state: false)
                                            DispatchQueue.global().async {
                                                sleep(1)
                                                viewModel.isNotifOn = false
                                            }
                                        }
                                    }
                                } else {
                                    NotificationsManager.shared.stop()
                                }
                            }
                    } footer: {
                        Text("label_notiffooter".localized)
                    }

                }
            }
        }
        .toast(message: toastText, isShowing: $isShowToast, config: .init())
        .navigationTitle("title_notifications".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

