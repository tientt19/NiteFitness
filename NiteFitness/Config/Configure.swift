//
//  Configure.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

//let APP_ENV = Environment.PRO

/// v1.1 - PRO
//var AUTH_SERVICE_URL = "https://id.1sk.vn/api"
//var FITNESS_SERVICE_URL = "https://fitness.1sk.vn/api/v1.1"
var CARE_SERVICE_URL = "https://care.1sk.vn/api/v1.0"
var STORE_SERVICE_URL = "https://1sk.vn/api/v1.0"
var CONNECT_SERVICE_URL = "https://api-connect.1sk.vn/api/v1.2"
//var WORDPRESS_SERVICE_URL = "https://1sk.vn/song-khoe/wp-json/wp/v2"
var UPLOAD_IMAGE_URL = "https://static.1sk.vn:8403/v1.0"

var SOCKET_ID_URL = "https://id-echo.1sk.vn"
var SOCKET_FITNESS_URL = "https://fitness-echo.1sk.vn"
var SOCKET_CARE_URL = "https://care-echo.1sk.vn"
//var SOCKET_TIMER_URL = "https://care-timer.1sk.vn"

//var SHARE_URL = "https://1sk.vn/"
var LANDING_FITNESS_URL = "https://1sk.vn/fit"
var LANDING_STORE_URL = "https://1sk.vn/store"
var GUIDE_CONNECTING_STRAVA_URL = ""
var GUIDE_TRACKING_STRAVA_URL = ""
var PRODUCT_SCALES_URL = ""
var PRODUCT_BP_URL = ""

/// v1.1 - DEV
//var AUTH_SERVICE_URL = "https://id-dev.1sk.vn/api"
//var FITNESS_SERVICE_URL = "https://fitness-dev.1sk.vn/api/v1.1"
//var CARE_SERVICE_URL = "https://care-dev.1sk.vn/api/v1.0"
//var STORE_SERVICE_URL = "https://ecom-dev.1sk.vn/api/v1.0"
//var CONNECT_SERVICE_URL = "https://dev-connect.1sk.vn/api/v1.2"
//var WORDPRESS_SERVICE_URL = "https://1sk.vn/song-khoe/wp-json/wp/v2"
//var UPLOAD_IMAGE_URL = "https://static.1sk.vn:8403/v1.0"
//
//var SOCKET_ID_URL = "https://echo-id-dev.1sk.vn"
//var SOCKET_FITNESS_URL = "https://echo-fitness-dev.1sk.vn"
//var SOCKET_CARE_URL = "https://echo-care-dev.1sk.vn"
//var SOCKET_TIMER_URL = "https://care-timer-dev.1sk.vn"
//
//var SHARE_URL = "https://dev-web.1sk.vn/"
//var LANDING_FITNESS_URL = "https://1sk.vn/fit"
//var LANDING_STORE_URL = "https://1sk.vn/store"
//var GUIDE_CONNECTING_STRAVA_URL = ""
//var GUIDE_TRACKING_STRAVA_URL = ""
//var PRODUCT_SCALES_URL = ""
//var PRODUCT_BP_URL = ""

/// v1.0
//let BASE_URL = "https://api.1sk.vn:8405/v1.0"

//let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
let APP_BUILD = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
let APP_APPSTORE_ID = "1554801349"
//let APP_APPSTORE = "itms-apps://itunes.apple.com/app/id1554801349"

let DEFAULT_URL = "https://1sk.vn/"

//enum Environment {
//    case DEV
//    case PRO
//}

class Configure: NSObject {
    static let shared = Configure()
    
    func setDataAuth(authModel: AuthModel) {
        KeyChainManager.shared.accessToken = authModel.accessToken ?? authModel.token
        
        SKUserDefaults.shared.tokenType = authModel.tokenType
        SKUserDefaults.shared.authType = authModel.authType?.value
        SKUserDefaults.shared.loginAuth = true
    }
    
    func setDataAuthSwitch(subAccount: AuthModel) {
        KeyChainManager.shared.accessToken = subAccount.accessToken
        
        SKUserDefaults.shared.authType = subAccount.tokenType
        SKUserDefaults.shared.loginAuth = true
    }
    
    func setDataUser(userModel: UserModel) {
        SKUserDefaults.shared.uuid = userModel.uuid
        SKUserDefaults.shared.phoneNumber = userModel.phoneNumber
        SKUserDefaults.shared.fullName = userModel.fullName
        SKUserDefaults.shared.avatar = userModel.avatar

        gUser = userModel
        
        NotificationCenter.default.post(name: .DID_CHANGE_PROFILE, object: nil)
    }
    
    func setRemoveDataLogout() {
        KeyChainManager.shared.accessToken = nil
        SKUserDefaults.shared.removeObject()
        
        gUser = nil
    }
    
    func isLogged() -> Bool {
        if SKUserDefaults.shared.loginAuth == true && KeyChainManager.shared.accessToken != nil {
            return true
            
        } else {
            return false
        }
    }
}

