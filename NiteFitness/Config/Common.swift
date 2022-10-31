//
//  Common.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation
import UIKit
//import SocketIO

//var gVersion = Version()
//var gWarning = Warning()
//var gAppLinks = AppLinks()
//var gAppShare = AppShare()
//var gAppSettings = AppSettings()

//var gUniversalLink: URL?

//var gThirdPartyLoginService = ThirdPartyLoginService()
//var gPushNotiModel: PushNotiModel?

var gUserIdReviewAppStore = 182 //1sk.elcom@gmail.com
var gTimeSystem: Int?
var gBadgeCare = 0
var gTimeDurationEndCall = 1800

//var gSocketCare: SocketIOClient?
//var gSocketTimer: SocketIOClient?
//var gSocketFitness: SocketIOClient?

//var gUser: UserModel?
//var gRecentWorkouts: [WorkoutModel]?
var gDeviceToken: String?
var gFCMToken: String?
var gTabBarController: UITabBarController?
var gPhoneHotline: String?

var haveInternetConnection = true
var gIsShowMarketingPopup = false
var gIsHaveInternetConnected = true

//var gListCartProduct: [CartProductSchema] = []
//var gListCountryModel: [CountryModel] = []

class Common: NSObject {
    
}

class NotiApp: NSObject {
    static var isUpdatePost = false
}
