//
//  SignInConfig.swift
//  myElcom
//
//  Created by Valerian on 13/05/2022.
//

import Foundation
import GoogleSignIn


let signInConfig = GIDConfiguration.init(clientID: "456213960307-fj0geurrliikq1opp9stgekbkm72f3l7.apps.googleusercontent.com")

let APP_ENV = Environment.DEV
var AUTH_SERVICE_URL = "http://api-dev.elcom.com.vn/api"
var NEWFEED_SERVICEE_URL = "http://api-dev.elcom.com.vn/api"
var WORDPRESS_SERVICE_URL = "https://1sk.vn/song-khoe/wp-json/wp/v2"
var BASE_URL = "http://api-dev.elcom.com.vn/api"
var FITNESS_SERVICE_URL = "https://fitness.1sk.vn/api/v1.1"
var SOCKET_TIMER_URL = ""
let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
let APP_APPSTORE = "itms-apps://itunes.apple.com/app/id1637843634"
let APP_APPSTORE_REVIEW = "https://apps.apple.com/app/id1637843634?action=write-review"
var SHARE_URL = "https://1sk.vn/"

enum Environment {
    case DEV
    case PRO
}
