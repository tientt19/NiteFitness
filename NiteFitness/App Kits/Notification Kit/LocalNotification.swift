//
//  LocalNotification.swift
//  1SK
//
//  Created by vuongbachthu on 10/21/21.
//

import Foundation
import UIKit

class LocalNotification {
    static let shared = LocalNotification()
    
    func createLocalNotification(title: String?, subtitle: String?, body: String?, badge: Bool) {
//        //creating the notification content
//        let content = UNMutableNotificationContent()
//
//        //adding title, subtitle, body and badge
//        if let `title` = title {
//            content.title = title
//        }
//        if let `subtitle` = subtitle {
//            content.subtitle = subtitle
//        }
//        if let `body` = body {
//            content.body = body
//        }
//        if badge == true {
//            content.badge = 1
//        }
//        content.sound = .default
//
//        //getting the notification trigger
//        //it will be called after 5 seconds
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
//
//        //getting the notification request
//        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
//
//        //adding the notification to notification center
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
