//
//  PushNotiModel.swift
//  1SK
//
//  Created by Thaad on 07/01/2022.
//

import Foundation

class PushNotiModel: NSObject {
    var type: String?
    var url: String?
    var screen: String?
    var data: PushNotiDataModel?
    
    init(object: [String: Any]?) {
        super.init()
        self.type = object?["type"] as? String
        self.url = object?["url"] as? String
        
        self.screen = object?["screen"] as? String
        
        if let data = object?["data"] as? [String: Any] {
            self.data = PushNotiDataModel.init(object: data)
        }
    }
}

class PushNotiDataModel: NSObject {
    var id: Int?
    
    init(object: [String: Any]?) {
        super.init()
        self.id = object?["id"] as? Int
    }
}
