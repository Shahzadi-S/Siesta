//
//  NotificationManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 16/03/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.scheduleNotification()
                print("🔍 Notifications Enabled")
            } else if let error {
                print("🔍 Notifications Disabled")
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Have you played today?"
        content.body = "Play now to flex your mind!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Add the notification request
        UNUserNotificationCenter.current().add(request)
    }
}
