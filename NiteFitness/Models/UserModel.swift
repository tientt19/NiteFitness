//
//  UserModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation
import UIKit

class UserModel: Codable {
    var id: Int?
    var uuid: String?
    var username: String?
    var email: String?
    var mobile: String?
    var fullName: String?
    var skype, facebook: String?
    var avatar: String?
    var address, birthday: String?
    var fbId, ggId: String?
    var activatedAt, emailVerifiedAt, mobileVerifiedAt, setPasswordAt: String?
    var phoneNumber, avatarUpdatedAt: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var canAccess, roles: String?
    var lastDeviceRequest: LastDeviceRequestModel?
    var gender: Gender?
    
//    var connect: UserConnectModel?
    
    var statusId: Int?
    var type: String?
    var height, weight: Double?
    var blood: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid, username, email, mobile
        case fullName
        case skype, facebook, avatar, address, birthday, gender
        case fbId
        case ggId
        case activatedAt
        case emailVerifiedAt
        case mobileVerifiedAt
        case setPasswordAt
        case phoneNumber
        case avatarUpdatedAt
        case createdAt
        case updatedAt
        case deletedAt
        case canAccess
        case roles
        case lastDeviceRequest
        case statusId, type
        case height, weight, blood
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.uuid = try? container.decode(String.self, forKey: .uuid)
        self.username = try? container.decode(String.self, forKey: .username)
        self.email = try? container.decode(String.self, forKey: .email)
        self.mobile = try? container.decode(String.self, forKey: .mobile)
        self.fullName = try? container.decode(String.self, forKey: .fullName)
        self.skype = try? container.decode(String.self, forKey: .skype)
        self.facebook = try? container.decode(String.self, forKey: .facebook)
        self.avatar = try? container.decode(String.self, forKey: .avatar)
        self.address = try? container.decode(String.self, forKey: .address)
        self.birthday = try? container.decode(String.self, forKey: .birthday)
        self.fbId = try? container.decode(String.self, forKey: .fbId)
        self.ggId = try? container.decode(String.self, forKey: .ggId)
        self.activatedAt = try? container.decode(String.self, forKey: .activatedAt)
        self.emailVerifiedAt = try? container.decode(String.self, forKey: .emailVerifiedAt)
        self.mobileVerifiedAt = try? container.decode(String.self, forKey: .mobileVerifiedAt)
        self.setPasswordAt = try? container.decode(String.self, forKey: .setPasswordAt)
        self.phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        self.avatarUpdatedAt = try? container.decode(String.self, forKey: .avatarUpdatedAt)
        self.createdAt = try? container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.deletedAt = try? container.decode(String.self, forKey: .deletedAt)
        self.canAccess = try? container.decode(String.self, forKey: .canAccess)
        self.roles = try? container.decode(String.self, forKey: .roles)
        self.lastDeviceRequest = try? container.decode(LastDeviceRequestModel.self, forKey: .lastDeviceRequest)
        
        self.statusId = try? container.decode(Int.self, forKey: .statusId)
        self.type = try? container.decode(String.self, forKey: .type)
        self.height = try? container.decode(Double.self, forKey: .height)
        self.weight = try? container.decode(Double.self, forKey: .weight)
        self.blood = try? container.decode(String.self, forKey: .blood)
        
        let genderId = try? container.decode(Int.self, forKey: .gender)
        switch genderId {
        case 0:
            self.gender = .male
            
        case 1:
            self.gender = .female
            
        default:
            break
        }
        
    }
    
    init() {
//        self.connect = UserConnectModel()
    }
    
    init(uuid: String, fullName: String, avatar: String) {
        self.uuid = uuid
        self.fullName = fullName
        self.avatar = avatar
    }
}

// MARK: LastDeviceRequestModel
class LastDeviceRequestModel: Codable {
    var id: Int?
    var engine: String?
    var systemInformation, platform, platformDetails, extensions: String?
    var isBot: Int?
    var createdAt, updatedAt, modelableType: String?
    var modelableId: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.engine = try? container.decode(String.self, forKey: .engine)
        self.systemInformation = try? container.decode(String.self, forKey: .systemInformation)
        self.platform = try? container.decode(String.self, forKey: .platform)
        self.platformDetails = try? container.decode(String.self, forKey: .platformDetails)
        self.extensions = try? container.decode(String.self, forKey: .extensions)
        self.isBot = try? container.decode(Int.self, forKey: .isBot)
        self.createdAt = try? container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.modelableType = try? container.decode(String.self, forKey: .modelableType)
        self.modelableId = try? container.decode(Int.self, forKey: .modelableId)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, engine
        case systemInformation
        case platform
        case platformDetails
        case extensions
        case isBot
        case createdAt
        case updatedAt
        case modelableType
        case modelableId
    }
}
