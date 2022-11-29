//
//  PageHomeModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class HomePageModel: Codable {
    var data: [BannersModel]?
    var doNotMiss: [BlogModel]?
    
    init() {
        self.data = []
        self.doNotMiss = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.data = try? container.decode([BannersModel].self, forKey: .data)
        self.doNotMiss = try? container.decode([BlogModel].self, forKey: .doNotMiss)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, doNotMiss
    }
}

class BannersModel: Codable {
    var id: Int?
    var title, description, link: String?
    var type: String?
    var image: String?
    var video: String?
    var status: Int?
    var page, typeAction: String?
    var typeFilter: String?
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.link = try? container.decode(String.self, forKey: .link)
        self.type = try? container.decode(String.self, forKey: .type)
        self.image = try? container.decode(String.self, forKey: .image)
        self.video = try? container.decode(String.self, forKey: .video)
        self.status = try? container.decode(Int.self, forKey: .status)
        self.page = try? container.decode(String.self, forKey: .page)
        self.typeAction = try? container.decode(String.self, forKey: .typeAction)
        self.typeFilter = try? container.decode(String.self, forKey: .typeFilter)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case description
        case link, type, image, video, status, page
        case typeAction
        case typeFilter
    }
}

