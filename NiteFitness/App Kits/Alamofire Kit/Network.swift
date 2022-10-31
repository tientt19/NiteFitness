//
//  Network.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation
import Alamofire

class Network {
    static var isConnected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
