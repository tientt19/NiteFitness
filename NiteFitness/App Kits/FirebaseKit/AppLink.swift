//
//  AppLink.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class AppLinks: NSObject {
    var appIosBundleID: String?
    var appIosStoreID: String?
    var appIosStoreURL: String?
    var appIosMinVersion: String?
    
    var appAndroidPackageName: String?
    var appAndroidStoreURL: String?
    var appAndroidMinVersion: Int?
    
    override init() {
        self.appIosBundleID = "com.elcom.OneSK"
        self.appIosStoreID = "1554801349"
        self.appIosStoreURL = "https://apps.apple.com/vn/app/1sk/id1554801349"
        self.appIosMinVersion = "1.0.1"
        
        self.appAndroidPackageName = "vn.onesk"
        self.appAndroidStoreURL = "https://play.google.com/store/apps/details?id=vn.onesk"
        self.appAndroidMinVersion = 6
    }
}

