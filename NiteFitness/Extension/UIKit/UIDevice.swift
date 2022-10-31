//
//  UIDevice.swift
//  myElcom
//
//  Created by Valerian on 31/07/2022.
//

import Foundation
import UIKit

extension UIDevice {
    
    enum DeviceCategory {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPhoneXR
        case iPadPro12inch
        case iPad
    }
    
    func deviceCategory() -> DeviceCategory {
        let height = UIScreen.main.bounds.size.height
        switch height {
        case 480:
            return .iPhone4
            
        case 568:
            return .iPhone5
            
        case 667:
            return .iPhone6
            
        case 736:
            return .iPhone6Plus
            
        case 812:
            return .iPhoneX
            
        case 896:
            return .iPhoneXR
            
        case 1366:
            return .iPadPro12inch
            
        default:
            return .iPad
        }
    }
}
