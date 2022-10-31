//
//  RemoteConfigManager.swift
//  myElcom
//
//  Created by Tiến Trần on 02/08/2022.
//

//import Foundation
////import FirebaseRemoteConfig
//
//// MARK: Enum RemoteConfigKey
//enum RemoteConfigKey: String {
//    case ThirdPartyLoginService = "Third_Party_Login_Service"
//    case UpdateAppVersion = "version_ios"
//}
//
//// MARK: Init RemoteConfig
//struct RemoteConfigManager {
//    static let shared = RemoteConfigManager()
//    
//    fileprivate var remoteConfig: RemoteConfig
//    
//    fileprivate init() {
//        self.remoteConfig = RemoteConfig.remoteConfig()
//    }
//    
//    func initRemoteConfig() {
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 0
//        self.remoteConfig.configSettings = settings
//    }
//    
//    func fetchRemoteConfig(completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
//        print("RemoteConfig fetchRemoteConfig 1")
//        
//        self.remoteConfig.fetch { (status, error) -> Void in
//            print("RemoteConfig fetchRemoteConfig 2")
//            
//            if status == .success {
//                self.remoteConfig.activate { changed, error in
//                    guard error == nil else {
//                        completion(false, error)
//                        return
//                    }
//                    
//                    self.setConfigAppleSignIn()
//                    self.setConfigVersion()
//                    
//                    completion(true, nil)
//                }
//                
//            } else {
//                completion(false, error)
//            }
//        }
//    }
//}
//
//// MARK: Get Value
//extension RemoteConfigManager {
//    private func getValueString(fromKey key: RemoteConfigKey) -> String? {
//        return self.remoteConfig.configValue(forKey: key.rawValue).stringValue
//    }
//    
//    private func getValueInt(fromKey key: RemoteConfigKey) -> Int? {
//        return self.remoteConfig.configValue(forKey: key.rawValue).numberValue.intValue
//    }
//    
//    private func getValueBool(fromKey key: RemoteConfigKey) -> Bool? {
//        return self.remoteConfig.configValue(forKey: key.rawValue).boolValue
//    }
//    
//    private func getValueJson(fromKey key: RemoteConfigKey) -> [String: Any]? {
//        return self.remoteConfig.configValue(forKey: key.rawValue).jsonValue as? [String: Any]
//    }
//}
//
//extension RemoteConfigManager {
//    func setConfigAppleSignIn() {
//        if let feature = RemoteConfigManager.shared.getValueJson(fromKey: .ThirdPartyLoginService) {
//            gThirdPartyLoginService.isActivated = feature["is_activated"] as? Bool
//        }
//    }
//    
//    // MARK: setConfigVersion
//    private func setConfigVersion() {
//        if let version = RemoteConfigManager.shared.getValueJson(fromKey: .UpdateAppVersion) {
//            gVersion.minVersion = version["min_version"] as? String
//            gVersion.latestVersion = version["latest_version"] as? String
//            gVersion.isReviewAppstore = version["is_review_appstore"] as? Bool
//            
//            /// Version Min
//            if let listMinVersion = gVersion.minVersion?.split(separator: ".") {
//                var version = ""
//                for item in listMinVersion {
//                    if item.count > 1 {
//                        version = "\(version)\(item)"
//                    } else {
//                        version = "\(version)0\(item)"
//                    }
//                }
//                gVersion.minVersionNumber = Int(version)
//            }
//            
//            /// Version Latest
//            if let listLatestVersion = gVersion.latestVersion?.split(separator: ".") {
//                var version = ""
//                for item in listLatestVersion {
//                    if item.count > 1 {
//                        version = "\(version)\(item)"
//                    } else {
//                        version = "\(version)0\(item)"
//                    }
//                }
//                gVersion.latestVersionNumber = Int(version)
//            }
//            
//            /// Version System
//            let listSystemVersion = APP_VERSION.split(separator: ".")
//            var version = ""
//            for item in listSystemVersion {
//                if item.count > 1 {
//                    version = "\(version)\(item)"
//                } else {
//                    version = "\(version)0\(item)"
//                }
//            }
//            gVersion.systemVersionNumber = Int(version)
//            
//            print("setConfigVersion minVersion: \(gVersion.minVersion ?? "null")")
//            print("setConfigVersion latestVersion: \(gVersion.latestVersion ?? "null")")
//            print("setConfigVersion ")
//            print("setConfigVersion minVersionNumber: \(gVersion.minVersionNumber ?? 0)")
//            print("setConfigVersion latestVersionNumber: \(gVersion.latestVersionNumber ?? 0)")
//            print("setConfigVersion systemVersionNumber: \(gVersion.systemVersionNumber ?? 0)")
//        }
//    }
//}
//
////MARK: - Apple Sign-in Activated
//class ThirdPartyLoginService: NSObject {
//    var isActivated: Bool?
//}
//
//// MARK: Version
//class Version: NSObject {
//    var minVersion: String?
//    var latestVersion: String?
//    var isReviewAppstore: Bool?
//    
//    var minVersionNumber: Int?
//    var latestVersionNumber: Int?
//    var systemVersionNumber: Int?
//}
