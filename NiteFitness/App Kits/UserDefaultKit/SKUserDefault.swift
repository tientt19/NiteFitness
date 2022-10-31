//
//  SKUserDefault.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import Foundation

class SKUserDefaults {
    static let shared = SKUserDefaults()
    private let skUserDefaults = UserDefaults(suiteName: "1SK")

    private init() {
        //
    }
    
    var uuid: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.uuid)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.uuid)
        }
    }
    
    var fullName: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.fullName)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.fullName)
        }
    }
    
    var avatar: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.avatar)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.avatar)
        }
    }
    
    var loginAuth: Bool? {
        get {
            return self.skUserDefaults?.bool(forKey: KeyUserDefaults.loginAuth)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.loginAuth)
        }
    }
    
    var tokenType: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.tokenType)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.tokenType)
        }
    }

    dynamic var numberOfUnreadNotification: Int {
        get {
            return self.skUserDefaults?.integer(forKey: KeyUserDefaults.numberOfUnreadNotification) ?? 0
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.numberOfUnreadNotification)
//            NotificationCenter.default.post(name: .unreadNotificationCountChanged, object: nil)
        }
    }
    
    func removeObject() {
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.uuid)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.avatar)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.fullName)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.tokenType)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.loginAuth)
    }
}

struct KeyUserDefaults {
    static let uuid = "uuid"
    static let avatar = "avatar"
    static let fullName = "fullName"
    static let tokenType = "tokenType"
    static let loginAuth = "loginAuth"
    static let numberOfUnreadNotification = "numberOfUnreadNotification"
}
