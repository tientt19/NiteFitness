//
//  SKUserDefaults.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import UIKit

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
    
    var phoneNumber: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.phoneNumber)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.phoneNumber)
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
    
    var authType: String? {
        get {
            return self.skUserDefaults?.string(forKey: KeyUserDefaults.authType)
        }
        set {
            self.skUserDefaults?.set(newValue, forKey: KeyUserDefaults.authType)
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
            NotificationCenter.default.post(name: .unreadNotificationCountChanged, object: nil)
        }
    }
    
    func removeObject() {
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.uuid)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.tokenType)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.loginAuth)
    }
    
    func deleteAccountObject() {
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.uuid)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.phoneNumber)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.avatar)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.fullName)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.tokenType)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.loginAuth)
        self.skUserDefaults?.removeObject(forKey: KeyUserDefaults.authType)
    }
}

//struct KeyUserDefaults {
//    static let uuid = "uuid"
//    static let phoneNumber = "phoneNumber"
//    static let fullName = "fullName"
//    static let avatar = "avatar"
//    static let tokenType = "tokenType"
//    static let loginAuth = "loginAuth"
//    static let authType = "authType"
//    static let numberOfUnreadNotification = "numberOfUnreadNotification"
//}

