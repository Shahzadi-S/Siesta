//
//  NotificationManager.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 16/03/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    private let messageIndexKey = "notificationMessageIndex"
    private let lastScheduledKey = "lastScheduledDate"
    
    // For users who weren't prompted in 1.0 but have since updated
    func checkNotificationPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                // User hasn't been prompted before so requesting permission now
                print("🔔 Permission not determined, requesting...")
                self.requestNotificationPermission()
            case .denied:
                // Permission denied – inform user to enable in settings
                print("🔕 Notifications denied – maybe show a prompt to enable in Settings")
            case .authorized, .provisional, .ephemeral:
                // Notifications are already authorized so checking if 28 days have passed
                print("🔔 Notifications already enabled")
                DispatchQueue.main.async {
                    self.checkIfNotificationsNeedToBeScheduled()
                }
            @unknown default:
                // Handle any unknown cases
                print("❓ Unknown notification state")
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.checkIfNotificationsNeedToBeScheduled()
                }
            } else {
                print("🔕 Permission denied: \(error?.localizedDescription ?? "No error")")
            }
        }
    }
    
    // Schedules 28 notifications with a rotating message index
    func scheduleBulkRotatingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let calendar = Calendar.current
        let now = Date()
        
        // Read last index from UserDefaults (defaults to 0)
        var currentIndex = UserDefaults.standard.integer(forKey: messageIndexKey)
        
        for dayOffset in 0..<28 {
            guard let futureDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else { continue }
            
            let message = notificationMessages[currentIndex % notificationMessages.count]
            currentIndex += 1
            
            let content = UNMutableNotificationContent()
            content.body = message
            content.sound = .default
            
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: futureDate)
            dateComponents.hour = 20
            dateComponents.minute = 00
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "daily_\(dayOffset)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
        
        // Save the next index so it resumes from the right point later
        UserDefaults.standard.set(currentIndex % notificationMessages.count, forKey: messageIndexKey)
        
        // Save the date when the notifications were scheduled
        UserDefaults.standard.set(now, forKey: lastScheduledKey)
    }
    
    /// Checks if it's time to schedule new notifications, based on last scheduled date
    private func checkIfNotificationsNeedToBeScheduled() {
        let calendar = Calendar.current
        let now = Date()
        
        // Check if it's been more than 28 days since the last notification schedule
        if let lastScheduled = UserDefaults.standard.object(forKey: lastScheduledKey) as? Date,
           let daysSince = calendar.dateComponents([.day], from: lastScheduled, to: now).day,
           daysSince < 28 {
            print("🗓 Notifications already scheduled within the last \(daysSince) days.")
            return
        }
        
        // If it's been more than 28 days, schedule new notifications
        scheduleBulkRotatingNotifications()
    }
    
    private let notificationMessages = [
        "Play now to flex your mind! 🧠",
        "Red, blue, green... what comes next?",
        "Your memory’s being challenged. Accept the mission?",
        "Ready or not, the puzzle’s waiting!",
        "Can you make it to the next level? Let’s find out!",
        "Repeat after me: Tap, tap, PLAY!",
        "The next level's waiting… and it’s trickier than ever!",
    ]
}


//import Foundation
//import UserNotifications
//
//class NotificationManager {
//
//    // For users who weren't prompted in 1.0 but have since updated
//    func checkNotificationPermissionStatus() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .notDetermined:
//                // Never asked before — safe to request now
//                self.requestNotificationPermission()
//            case .denied:
//                print("🔕 Notifications denied – maybe show a prompt to enable in Settings")
//            case .authorized, .provisional, .ephemeral:
//                print("🔔 Notifications already enabled")
//            @unknown default:
//                print("❓ Unknown notification state")
//            }
//        }
//    }
//
//    func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                self.scheduleNotification()
//                print("🔍 Notifications Enabled")
//            } else if let error {
//                print("🔍 Notifications Disabled")
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func scheduleNotification() {
//        let content = UNMutableNotificationContent()
//
//        let weekday = Calendar.current.component(.weekday, from: Date()) // Sunday = 1 ... Saturday = 7
//        let index = (weekday - 1) % notificationTitles.count
//        content.body = notificationTitles[index]
//        content.sound = UNNotificationSound.default
//
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 00
//
//        // Create the trigger as a repeating event.
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        // Choose a random identifier
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        // Add the notification request
//        UNUserNotificationCenter.current().add(request)
//    }
//
//    private let notificationTitles = [
//        "Play now to flex your mind! 🧠",
//        "Red, blue, green... what comes next?",
//        "Your memory’s being challenged. Accept the mission?",
//        "Ready or not, the puzzle’s waiting!",
//        "Can you make it to the next level? Let’s find out!",
//        "Repeat after me: Tap, tap, PLAY!",
//        "The next level's waiting… and it’s trickier than ever!",
//    ]
//}
