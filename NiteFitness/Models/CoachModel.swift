//
//  CoachModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class CoachModel: Codable, Equatable {
    var id: Int?
    var userId: Int?
    var name: String?
    var slug: String?
    var avatar: String?
    var gender: String?
    var description: String?

    static func == (lhs: CoachModel, rhs: CoachModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case slug
        case avatar
        case gender
        case description
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.userId = try? values.decode(Int.self, forKey: .userId)
        self.name = try? values.decode(String.self, forKey: .name)
        self.slug = try? values.decode(String.self, forKey: .slug)
        self.avatar = try? values.decode(String.self, forKey: .avatar)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.description = try? values.decode(String.self, forKey: .description)
    }
}
