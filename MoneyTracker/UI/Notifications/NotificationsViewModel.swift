//
//  NotificationsViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 26.07.2022.
//

import SwiftUI
import Combine

class NotificationsViewModel: BaseViewModel {
    @Published var isNotifOn: Bool = false
    
    /// Load all
    override func loadData() {
        self.isNotifOn = self.storageManager.isNotifEnable()
    }
    
    /// Update notifications state
    func setNotifications(state: Bool) {
        isNotifOn = state
        storageManager.setNotifEnable(isEnable: state)
        
        if isNotifOn {
            notificationsManager.requestPermission { isSuccess in
                if isSuccess {
                    self.notificationsManager.stop()
                    self.notificationsManager.start(
                        title: "notif_title".localized,
                        body: "notif_body".localized,
                        hour: 19, minute: 00)
                }
            }
        } else {
            self.notificationsManager.stop()
        }
    }
}
