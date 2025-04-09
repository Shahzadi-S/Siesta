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
        
        let weekday = Calendar.current.component(.weekday, from: Date()) // Sunday = 1 ... Saturday = 7
        let index = (weekday - 1) % notificationTitles.count
        content.body = notificationTitles[index]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 00
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    private let notificationTitles = [
        "Play now to flex your mind! 🧠",
        "Red, blue, green... what comes next?",
        "Your memory’s being challenged. Accept the mission?",
        "Ready or not, the puzzle’s waiting!",
        "Can you make it to the next level? Let’s find out!",
        "Repeat after me: Tap, tap, PLAY!",
        "The next level's waiting… and it’s trickier than ever!",
    ]
}
