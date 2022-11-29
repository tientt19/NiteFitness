//
//  BlogModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

// MARK: - BlogModel
class BlogModel: Codable, Equatable {
    var id: Int?
    var title, description, shortDescription, content: String?
    var slug, linkShare, createdAt: String?
    var thumbImage: String?
    var source, status, isActive, isFeatured: String?
    var totalWatch, updateBy, deleteBy: String?
    var createdBy: CreatedBy?
    var authors: String?
    var friendlyUrl: String?
    
    var category: [CategoryModel]?
    var tag: [TagModel]?
    var tags: [TagModel]?
    var categories: [CategoriesVideo]?
    
    var categoryType: CategoryType?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case content, slug, thumbImage, source, status, linkShare
        case isActive, createdAt, description, shortDescription
        case isFeatured
        case totalWatch
        case createdBy
        case updateBy
        case deleteBy
        case category, categories
        case tag, tags, authors
        case friendlyUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.shortDescription = try? container.decode(String.self, forKey: .shortDescription)
        self.content = try? container.decode(String.self, forKey: .content)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.linkShare = try? container.decode(String.self, forKey: .linkShare)
        self.createdAt = try? container.decode(String.self, forKey: .createdAt)
        self.thumbImage = try? container.decode(String.self, forKey: .thumbImage)
        self.source = try? container.decode(String.self, forKey: .source)
        self.status = try? container.decode(String.self, forKey: .status)
        self.isActive = try? container.decode(String.self, forKey: .isActive)
        self.isFeatured = try? container.decode(String.self, forKey: .isFeatured)
        self.totalWatch = try? container.decode(String.self, forKey: .totalWatch)
        self.updateBy = try? container.decode(String.self, forKey: .updateBy)
        self.deleteBy = try? container.decode(String.self, forKey: .deleteBy)
        self.createdBy = try? container.decode(CreatedBy.self, forKey: .createdBy)
        self.authors = try? container.decode(String.self, forKey: .authors)
        self.friendlyUrl = try? container.decode(String.self, forKey: .friendlyUrl)
        
        self.categories = try? container.decode([CategoriesVideo].self, forKey: .categories)
        self.category = try? container.decode([CategoryModel].self, forKey: .category)
        
        self.tags = []
        if let tag = try? container.decode([TagModel].self, forKey: .tag) {
            self.tag = tag
        } else {
            self.tag = try? container.decode([TagModel].self, forKey: .tags)
        }
    }

    static func == (lhs: BlogModel, rhs: BlogModel) -> Bool {
        return lhs.id == rhs.id
    }
    
//    func getCategoryIDs() -> String {
//        let categoryIDs = self.category?.map({ return String($0.id!) })
//        return categoryIDs!.joined(separator: ",")
//    }
}

class CreatedBy: Codable {
    var createdAt: String?
    var username: String?
    var fullName: String?
    var email: String?
    var id: Int?
    var userId: Int?
    var updatedAt: String?
    var information: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case username
        case email
        case id
        case userId
        case updatedAt
        case information
        case fullName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.createdAt = try? container.decodeIfPresent(String.self, forKey: .createdAt)
        self.username = try? container.decodeIfPresent(String.self, forKey: .username)
        self.email = try? container.decodeIfPresent(String.self, forKey: .email)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.userId = try? container.decodeIfPresent(Int.self, forKey: .userId)
        self.updatedAt = try? container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.information = try? container.decodeIfPresent(String.self, forKey: .information)
        self.fullName = try? container.decodeIfPresent(String.self, forKey: .fullName)
    }
}

// MARK: - Category
class CategoryModel: Codable {
    let id: Int?
    var name, slug, parentId: String?
    let status, type: String?
    let parent: ParentModel?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case parentId
        case status, type, parent
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.parentId = try? container.decode(String.self, forKey: .parentId)
        self.status = try? container.decode(String.self, forKey: .status)
        self.type = try? container.decode(String.self, forKey: .type)
        self.parent = try? container.decode(ParentModel.self, forKey: .parent)
    }
}

// MARK: - Parent
class ParentModel: Codable {
    let id, name, slug, parentId: String?
    let status, type, parent: String?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.parentId = try? container.decode(String.self, forKey: .parentId)
        self.status = try? container.decode(String.self, forKey: .status)
        self.type = try? container.decode(String.self, forKey: .type)
        self.parent = try? container.decode(String.self, forKey: .parent)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, slug, parentId
        case status, type, parent
    }
}

// MARK: - Tag
class TagModel: Codable {
    let id: Int?
    var name, slug, status: String?
    var pivot: Pivot?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.status = try? container.decode(String.self, forKey: .status)
        self.pivot = try? container.decode(Pivot.self, forKey: .pivot)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, status
        case pivot
    }
}

// MARK: - Tag
class Pivot: Codable {
    var blogId, tagId: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blogId = try? container.decode(String.self, forKey: .blogId)
        self.tagId = try? container.decode(String.self, forKey: .tagId)
    }
    
    enum CodingKeys: String, CodingKey {
        case blogId
        case tagId
    }
}

