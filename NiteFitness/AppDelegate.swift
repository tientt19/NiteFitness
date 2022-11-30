//
//  AppDelegate.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setInitRootViewController()
        self.onDisableDarkmode()
        self.initFirebaseConfigure()
        return true
    }
    
    //MARK: - DISABLE DARKMODE
    private func onDisableDarkmode() {
        let iOSVersion = ProcessInfo().operatingSystemVersion.majorVersion
        if iOSVersion >= 13 { // iOS version < 13.0.0
            window?.overrideUserInterfaceStyle = .light;
        }
    }
    
    //MARK: - Init Firebase
    private func initFirebaseConfigure() {
        FirebaseApp.configure()
    }
    
    // MARK: ViewController
    func setInitRootViewController() {
        let iOSVersion = ProcessInfo().operatingSystemVersion.majorVersion
        if iOSVersion < 13 { // iOS version < 13.0.0
            // Facebook
            let frame = UIScreen.main.bounds
            let windowSize = CGSize(width: min(frame.width, frame.height), height: max(frame.width, frame.height))
            window = UIWindow(frame: CGRect(origin: .zero, size: windowSize))
            let rootController = SplashScreenRouter.setupModule()
            window?.rootViewController = rootController
            window?.makeKeyAndVisible()
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
        
}

// MARK: - AppUtility Orientation
extension AppDelegate {
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

