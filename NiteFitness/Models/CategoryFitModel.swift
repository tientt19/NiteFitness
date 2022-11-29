//
//  CategoryFitModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class CategoryFitModel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var image: String?
    var slug: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case slug
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.description = try? container.decode(String.self, forKey: .description)
        self.name = try? container.decode(String.self, forKey: .name)
        self.image = try? container.decode(String.self, forKey: .image)
        self.slug = try? container.decode(String.self, forKey: .slug)
    }
}

class CategoriesModel: Codable {
    var id: Int?
    var name, slug: String?
    var image: String?
    var description: String?
    var parentID, type, status, count: Int?
    var postsCount, videosCount: Int?
    var children: [Children]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case description
        case parentID
        case type, status, count
        case postsCount
        case videosCount
        case children
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.description = try? container.decode(String.self, forKey: .description)
        self.name = try? container.decode(String.self, forKey: .name)
        self.image = try? container.decode(String.self, forKey: .image)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.parentID = try? container.decode(Int.self, forKey: .description)
        self.type = try? container.decode(Int.self, forKey: .type)
        self.status = try? container.decode(Int.self, forKey: .status)
        self.count = try? container.decode(Int.self, forKey: .count)
        self.postsCount = try? container.decode(Int.self, forKey: .postsCount)
        self.videosCount = try? container.decode(Int.self, forKey: .videosCount)
        self.children = try? container.decode([Children].self, forKey: .children)
    }
}


class Children: Codable {
    var id: Int?
    var name, slug: String?
    var image: String?
    var description: String?
    var parentID, type, status, count: Int?
    var postsCount, videosCount: Int?
    var children: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case description
        case parentID
        case type, status, count
        case postsCount
        case videosCount
        case children
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.description = try? container.decode(String.self, forKey: .description)
        self.name = try? container.decode(String.self, forKey: .name)
        self.image = try? container.decode(String.self, forKey: .image)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.parentID = try? container.decode(Int.self, forKey: .description)
        self.type = try? container.decode(Int.self, forKey: .type)
        self.status = try? container.decode(Int.self, forKey: .status)
        self.count = try? container.decode(Int.self, forKey: .count)
        self.postsCount = try? container.decode(Int.self, forKey: .postsCount)
        self.videosCount = try? container.decode(Int.self, forKey: .videosCount)
        self.children = try? container.decode(String.self, forKey: .children)
    }
}

