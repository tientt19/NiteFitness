//
//  AuthModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class AuthModel: Codable {
    var token: String?
    var accessToken: String?
    var tokenType: String?
    
    var customer: UserModel?
    var authType: AuthType?
    
    var type: String?
    var accountType: AccountType?
    
    enum CodingKeys: String, CodingKey {
        case accessToken, token, tokenType, type, customer
    }
    
    init() {
        self.customer = UserModel()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.token = try? container.decode(String.self, forKey: .token)
        self.accessToken = try? container.decode(String.self, forKey: .accessToken)
        self.tokenType = try? container.decode(String.self, forKey: .tokenType)
        self.customer = try? container.decode(UserModel.self, forKey: .customer)
        
        self.type = try? container.decode(String.self, forKey: .type)
        
        switch self.type {
        case AccountType.Account.value:
            self.accountType = .Account
            
        case AccountType.SubAccount.value:
            self.accountType = .SubAccount
            
        default:
            break
        }
    }
}

enum AccountType {
    case Account
    case SubAccount
    
    var value: String {
        switch self {
        case .Account:
            return "account"
            
        case .SubAccount:
            return "sub_account"
            
        }
    }
}

// MARK: AuthType
enum AuthType {
    case Phone
    case Facebook
    case Google
    case Apple
    
    var value: String {
        switch self {
        case .Phone:
            return "Phone"
            
        case .Facebook:
            return "Facebook"
            
        case .Google:
            return "Google"
            
        case .Apple:
            return "Apple"
        }
    }
}

