//
//  NotificationManager.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/12/21.
//

import UserNotifications

struct NotificationHelper {

    static func requestForPermission(completion: @escaping(Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            completion(granted ? true : false)
        }
    }

    static func scheduleLocalNotification(hour: Int, minute: Int, body: String) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Your daily joke is here. Keep smiling!"
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request)
    }

}
