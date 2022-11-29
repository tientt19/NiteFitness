//
//  HomeFitnessModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation


class HomeFitnessModel: Codable {
    var banner: [BannersModel]?
    var categories: [ActivitySubjectModel]?
    var interested: [InterestedModel]?
    
    init() {
       
    }
}

class BannerModel: Codable {
    var image: String?
    var link: String?
    var status: String?
    var type: BannerType?
    
    var id: String?
    var title: String?
    var description: String?
    var video: String?
    var page: String?
    var color: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.image = try? container.decode(String.self, forKey: .image)
        self.link = try? container.decode(String.self, forKey: .link)
        self.status = try? container.decode(String.self, forKey: .status)
        self.type = try? container.decode(BannerType.self, forKey: .type)
        
        self.id = try? container.decode(String.self, forKey: .id)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.video = try? container.decode(String.self, forKey: .video)
        self.page = try? container.decode(String.self, forKey: .page)
        self.color = try? container.decode(String.self, forKey: .color)
    }
    
    enum CodingKeys: String, CodingKey {
        case image, link
        case status, type
        case id, title, description, video, page, color
    }
}

class ActivitySubjectModel: Codable, Equatable {
    var id: Int?
    var name, image, slug, description: String?
    var attributes: [AttributeModel]?
    var isSelected: Bool?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.image = try? container.decode(String.self, forKey: .image)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.attributes = try? container.decode([AttributeModel].self, forKey: .attributes)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case image, slug, attributes
    }
    
    static func == (lhs: ActivitySubjectModel, rhs: ActivitySubjectModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class InterestedModel: Codable {
    var id: Int?
    var name, description, slug, type: String?
    var image, trailer, timeAction, order: String?
    var duration, durationDisplay, category: String?
    var link: String?
    var isLike, isView: Int?
    var details: [DetailsModel]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.image = try? container.decode(String.self, forKey: .image)
        self.trailer = try? container.decode(String.self, forKey: .trailer)
        self.duration = try? container.decode(String.self, forKey: .duration)
        self.durationDisplay = try? container.decode(String.self, forKey: .durationDisplay)
        self.category = try? container.decode(String.self, forKey: .category)
        self.isLike = try? container.decode(Int.self, forKey: .isLike)
        self.timeAction = try? container.decode(String.self, forKey: .timeAction)
        self.order = try? container.decode(String.self, forKey: .order)
        self.isView = try? container.decode(Int.self, forKey: .isView)
        self.type = try? container.decode(String.self, forKey: .type)
        self.link = try? container.decode(String.self, forKey: .link)
        self.details = try? container.decode([DetailsModel].self, forKey: .details)
    }
    
    init(workoutModel: WorkoutModel) {
        self.id = workoutModel.id
        self.name = workoutModel.name
        self.image = workoutModel.details?.first?.exercise?.image
        self.type = "workout"
    }
    
    init(videoModel: VideoModel) {
        self.id = videoModel.id
        self.name = videoModel.name
        self.image = videoModel.image
        self.type = "video"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case slug, image, trailer, duration
        case durationDisplay
        case category
        case isLike
        case timeAction
        case details, order
        case isView
        case type, link
    }
}

class DetailsModel: Codable {
    var attribute: AttributeModel?
    var value: ValueModel?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute = try? container.decode(AttributeModel.self, forKey: .attribute)
        self.value = try? container.decode(ValueModel.self, forKey: .value)
    }
    
    enum CodingKeys: String, CodingKey {
        case attribute, value
    }
}

class AttributeModel: Codable {
    var id: Int?
    var name: String?
    var values: [AtrributeValueModel]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.values = try? container.decode([AtrributeValueModel].self, forKey: .values)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case values
    }
}

class AtrributeValueModel: Codable {
    var id: Int?
    var name: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}


class ValueModel: Codable {
    var id, name: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
