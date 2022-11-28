//
//  PostHealthModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 28/11/2022.
//

import Foundation

class PostHealthModel: Codable {
    var id: Int?
    var yoastHeadJson: YoastHeadJson?
    var date: String?
    var link: String?
    var yoastHead: String?
    var categories: [Int]?
    var content: ContentHealthyPost?
    var postImages: PostImage?
    var postDate: String?
    var postTitle: String?
    var postCategories: [PostCategories]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case yoastHeadJson
        case categories
        case yoastHead
        case date
        case link
        case content
        case postImages
        case postDate
        case postTitle
        case postCategories
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.yoastHeadJson = try? container.decode(YoastHeadJson.self, forKey: .yoastHeadJson)
        self.date = try? container.decode(String.self, forKey: .date)
        self.link = try? container.decode(String.self, forKey: .link)
        self.yoastHead = try? container.decode(String.self, forKey: .yoastHead)
        self.categories = try? container.decode([Int].self, forKey: .categories)
        self.content = try? container.decode(ContentHealthyPost.self, forKey: .content)
        self.postImages = try? container.decode(PostImage.self, forKey: .postImages)
        self.postDate = try? container.decode(String.self, forKey: .postDate)
        self.postTitle = try? container.decode(String.self, forKey: .postTitle)
        self.postCategories = try? container.decode([PostCategories].self, forKey: .postCategories)
    }
}

//MARK: - PostImage
class PostImage: Codable {
    var thumbnail: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail
        case medium
        case large
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.thumbnail = try? container.decode(String.self, forKey: .thumbnail)
        self.medium = try? container.decode(String.self, forKey: .medium)
        self.large = try? container.decode(String.self, forKey: .large)
    }
}

//MARK: - YoastHeadJson
class YoastHeadJson: Codable {
    var title: String?
    var ogDescription: String?
    var ogImage: [ImageContent]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case ogDescription
        case ogImage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.ogDescription = try? container.decode(String.self, forKey: .ogDescription)
        self.ogImage = try? container.decode([ImageContent].self, forKey: .ogImage)
        if let title = try? container.decode(String.self, forKey: .title) {
            self.title = title.replaceCharacter(target: " - 1SK - Sống khỏe", withString: "")
        }
    }
}


//MARK: - ContentHealthyPost
class ContentHealthyPost: Codable {
    var rendered: String?
    
    enum CodingKeys: String, CodingKey {
        case rendered
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.rendered = try? container.decode(String.self, forKey: .rendered)
    }
}

//MARK: - ImageContent
class ImageContent: Codable {
    var url: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try? container.decode(String.self, forKey: .url)
        self.type = try? container.decode(String.self, forKey: .type)
    }
}

//MARK: - PostCategories
class PostCategories: Codable {
    var termId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case termId
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.termId = try? container.decode(Int.self, forKey: .termId)
        self.name = try? container.decode(String.self, forKey: .name)
    }
}
