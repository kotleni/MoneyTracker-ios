//
//  SettingsView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import SwiftUI

// eggs counter
fileprivate var eggsCounter: Int = 0

struct SettingsView: View {
    @EnvironmentObject var router: CheckoutViewsRouter
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isShowPremiumWarn: Bool = false
    @State private var isShowResetPaymentsAlert: Bool = false
    @State private var isShowResetPaymentsToast: Bool = false
    
    var body: some View {
        Form {
            Section {
                if viewModel.isPremium {
                    Text("label_premiumactive".localized)
                } else if viewModel.premiumPrice.isEmpty {
                    ProgressView()
                } else {
                    Button(action: {
                        viewModel.purshacePremium()
                    }, label: {
                        VStack {
                            HStack {
                                Text("label_premiumsubscribe".localized)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                            HStack {
                                Text("label_premiumaboutleft".localized + viewModel.premiumPrice + "label_premiumaboutright".localized)
                                    .opacity(0.7)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                        }
                    })
                }
                
            } header: {
                Text("label_subscribe".localized)
            }
            
            Section {
                // notifications toggle
                HStack {
                    Image(systemName: "bell.fill")
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    Toggle("label_notifications".localized, isOn: $viewModel.isNotifOn)
                        .onChange(of: viewModel.isNotifOn) { value in
                            if(!viewModel.isPremium) {
                                isShowPremiumWarn = true
                                DispatchQueue.global().async {
                                    sleep(1)
                                    viewModel.isNotifOn = false
                                }
                                return
                            }
                            
                            viewModel.setNotifications(state: viewModel.isNotifOn)
                            
                            if viewModel.isNotifOn {
                                let center  = UNUserNotificationCenter.current()

                                center.requestAuthorization(options: [.alert, .badge]) { (granted, error) in
                                    if error == nil {
                                        NotificationsManager.shared.stop()
                                        NotificationsManager.shared.start(
                                            title: "notif_title".localized,
                                            body: "notif_body".localized,
                                            hour: 19,
                                            minute: 00
                                        )
                                    }
                                }
                            } else {
                                NotificationsManager.shared.stop()
                            }
                        }
                        .padding(.leading, 4)
                }
                
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
                    Button(action: {
                        router.pushTo(view: CheckoutView.builder.makeView(ChangeCurrencyView(viewModel: viewModel), withNavigationTitle: "Выбор валюты"))
                    }, label: {
                        HStack {
                            Text("btn_selectcurrency".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    .padding(.leading, 4)
                    .padding(.trailing, 2)
                    .foregroundColor(Color("DefaultText"))
                }
                
                HStack {
                    Image(systemName: "tag.fill")
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.red))
                    Button(action: {
                        router.pushTo(view: CheckoutView.builder.makeView(TagsEditorView(viewModel: viewModel), withNavigationTitle: "Редактор тегов"))
                    }, label: {
                        HStack {
                            Text("Изменить теги".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    .padding(.leading, 4)
                    .padding(.trailing, 2)
                    .foregroundColor(Color("DefaultText"))
                }
                
                // if developer mode activate
                if viewModel.isDeveloperOn {
                    HStack {
                        Image(systemName: "hammer.fill")
                            .frame(width: 22, height: 22)
                            .padding(4)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                        Button(action: {
                            router.pushTo(view: CheckoutView.builder.makeView(DevMenuView(viewModel: viewModel), withNavigationTitle: "Developer Menu"))
                        }, label: {
                            HStack {
                                Text("Developer Menu".localized)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        })
                        .padding(.leading, 4)
                        .padding(.trailing, 2)
                        .foregroundColor(Color("DefaultText"))
                    }

                }
                
                HStack {
                    Image(systemName: "info.circle.fill")
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.indigo))
                    Button(action: {
                        router.pushTo(view: CheckoutView.builder.makeView(AboutAppView(viewModel: viewModel), withNavigationTitle: "О приложении"))
                    }, label: {
                        HStack {
                            Text("О приложении".localized)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    })
                    .padding(.leading, 4)
                    .padding(.trailing, 2)
                    .foregroundColor(Color("DefaultText"))
                }
                
                // reset paymetns btn
                HStack {
                    Image(systemName: "trash.fill")
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange))
                    Button {
                        isShowResetPaymentsAlert = true
                    } label: {
                        Text("btn_resetpayments".localized)
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 4)
                }
            }
        }
        .toast(message: "toast_paymentsdeleted".localized, isShowing: $isShowResetPaymentsToast, config: .init())
        .toast(message: "premium_warn".localized, isShowing: $isShowPremiumWarn, config: .init())
        .alert("label_deletepayments".localized, isPresented: $isShowResetPaymentsAlert) {
            Button("btn_yes".localized) {
                viewModel.removeAllPayments()
                isShowResetPaymentsAlert = false
                isShowResetPaymentsToast = true
            }
            Button("btn_no".localized) {
                isShowResetPaymentsAlert = false
            }
        }
    }
}


struct AboutAppView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Form {
            // developer text
            Text("label_developer".localized + "\(Static.developerString)")
                .onTapGesture {
                    trackEggs()
                }
            
            // version text
            Text("label_version".localized + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "error")")
            
            // appstore btn
            Button {
                guard let url = URL(string: Static.appstoreUrl) else { return }
                UIApplication.shared.open(url)
            } label: {
                Text("btn_appinappstore".localized)
            }
            
            // github btn
            Button {
                guard let url = URL(string: Static.githubUrl) else { return }
                UIApplication.shared.open(url)
            } label: {
                Text("btn_appingithub".localized)
            }
        }
    }
    
    // track current state of eggs
    private func trackEggs() {
        eggsCounter += 1
        if eggsCounter == 4 {
            viewModel.isDeveloperOn = true
            HapticManager.shared.success()
        }
    }
}
