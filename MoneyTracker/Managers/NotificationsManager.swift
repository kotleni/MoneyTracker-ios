//
//  NotificationsManager.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 12.07.2022.
//

import SwiftUI

/// Notifications manager
final class NotificationsManager {
    /// Start new notifications task
    func start(title: String, body: String, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }
    
    /// Stop all notifications task
    func stop() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
    
    /// Request notifications permission
    func requestPermission(callback: @escaping (_ isSuccess: Bool) -> Void) {
        let center  = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge]) { (_, error) in
            let isSucess = (error == nil)
            callback(isSucess)
        }
    }
}
