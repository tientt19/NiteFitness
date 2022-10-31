//
//  NotificationName.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import Foundation

extension Notification.Name {
    static let applicationWillEnterForeground = Notification.Name("applicationWillEnterForeground")
    static let applicationDidEnterBackground = Notification.Name("applicationDidEnterBackground")
    static let ToggleAuthUINotification = Notification.Name("ToggleAuthUINotification")
    static let connectionAvailable = Notification.Name("ConnectionAvailable")
    static let connectionUnavailable = Notification.Name("ConnectionNotAvailable")
    static let tokenExpire = Notification.Name("TokenExpire")
    static let applicationOSNotificationOpenedBlock = Notification.Name("applicationOSNotificationOpenedBlock")

}
