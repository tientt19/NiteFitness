//
//  VideoModel.swift
//  1SK
//
//  Created by tuyenvx on 18/01/2021.
//

import Foundation

enum CategoryType: Int {
    case videoFit = 1
    case blogFit = 2
    case videoCare = 3
    case blogCare = 4
    case none = 0
}

class VideoModel: Codable, Equatable {
    var id: Int?
    var name: String?
    var description: String?
    var slug: String?
    var image: String?
    var trailer: String?
    var duration: String?
    var durationDisplay: String?
    var category: ActivitySubjectModel?
    var categoryName: String?
    var isLike: Int?
    var timeAction: Int?
    var details: [VideoDetailModel]?
    var coach: CoachModel?
    var linkShare: String?
    var link: String?
    var type: String?
    var mimeType: String?
    var size: Int?
    var status: Int?
    var resolution: ResolutionVideo?
    var categories: [CategoriesVideo]?
    var tags: [TagModel]?
    var segments: [SegmentVideo]?
    var source: String?
    var categoryType: CategoryType?
    
    // new
    var trailerCdn: String?
    var url: String?
    var categoryId: Int?
    var coachId: String?
    var urlM3u8: String?
    var position: [PositionVideo]?
    var statusConvert: Int?
    var createdBy: CreatedVideo?
    var authors: String?
    var history: HistoryVideo?
    var createdAt: String?
    var updatedAt: String?
    var isLiked: Bool?
    var portals: [PortalsVideo]?
    
    var videoType: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case slug, image, trailer, duration
        case durationDisplay, category, categoryName
        case isLike, timeAction, details
        case coach, link, linkShare, type, mimeType, size, status
        case resolution
        case categories
        case tags
        case source
        case segments
        
        case trailerCdn
        case url
        case categoryId
        case coachId
        case urlM3u8
        case position
        case statusConvert
        case createdBy
        case authors
        case history
        case createdAt
        case updatedAt
        case isLiked
        case portals
        case videoType
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? values.decodeIfPresent(String.self, forKey: .name)
        self.description = try? values.decodeIfPresent(String.self, forKey: .description)
        self.slug = try? values.decodeIfPresent(String.self, forKey: .slug)
        self.image = try? values.decodeIfPresent(String.self, forKey: .image)
        self.trailer = try? values.decodeIfPresent(String.self, forKey: .trailer)
        self.duration = try? values.decodeIfPresent(String.self, forKey: .duration)
        self.durationDisplay = try? values.decodeIfPresent(String.self, forKey: .durationDisplay)
        self.category = try? values.decodeIfPresent(ActivitySubjectModel.self, forKey: .category)
        self.categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        self.isLike = try? values.decodeIfPresent(Int.self, forKey: .isLike)
        self.timeAction = try? values.decodeIfPresent(Int.self, forKey: .timeAction)
        self.details = try? values.decodeIfPresent([VideoDetailModel].self, forKey: .details)
        self.coach = try? values.decodeIfPresent(CoachModel.self, forKey: .coach)
        self.linkShare = try? values.decodeIfPresent(String.self, forKey: .linkShare)
        self.link = try? values.decodeIfPresent(String.self, forKey: .link)
        self.type = try? values.decodeIfPresent(String.self, forKey: .type)
        self.mimeType = try? values.decodeIfPresent(String.self, forKey: .mimeType)
        self.size = try? values.decodeIfPresent(Int.self, forKey: .size)
        self.status = try? values.decodeIfPresent(Int.self, forKey: .status)
        self.resolution = try? values.decodeIfPresent(ResolutionVideo.self, forKey: .resolution)
        self.categories = try? values.decodeIfPresent([CategoriesVideo].self, forKey: .categories)
        self.tags = try? values.decodeIfPresent([TagModel].self, forKey: .tags)
        self.source = try? values.decodeIfPresent(String.self, forKey: .source)
        self.segments = try? values.decodeIfPresent([SegmentVideo].self, forKey: .segments)
        
        self.trailerCdn = try? values.decodeIfPresent(String.self, forKey: .trailerCdn)
        self.url = try? values.decodeIfPresent(String.self, forKey: .url)
        self.categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
        self.coachId = try? values.decodeIfPresent(String.self, forKey: .coachId)
        self.urlM3u8 = try? values.decodeIfPresent(String.self, forKey: .urlM3u8)
        self.position = try? values.decodeIfPresent([PositionVideo].self, forKey: .position)
        self.statusConvert = try? values.decodeIfPresent(Int.self, forKey: .statusConvert)
        self.createdBy = try? values.decodeIfPresent(CreatedVideo.self, forKey: .createdBy)
        self.authors = try? values.decodeIfPresent(String.self, forKey: .authors)
        self.history = try? values.decodeIfPresent(HistoryVideo.self, forKey: .history)
        self.createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        self.isLiked = try? values.decodeIfPresent(Bool.self, forKey: .isLiked)
        self.portals = try? values.decodeIfPresent([PortalsVideo].self, forKey: .portals)
        
        self.videoType = try? values.decodeIfPresent(Int.self, forKey: .videoType)
    }
    
    static func == (lhs: VideoModel, rhs: VideoModel) -> Bool {
        return lhs.id == rhs.id
    }

    func getDetailsContent() -> String {
        var detailsTitle = ""
        if let atribute = details?.first(where: {$0.attribute?.name == "Loại bài tập"}) {
            detailsTitle.append(atribute.value?.name ?? "")
            detailsTitle.append(" • ")
        }
        let time = duration?.toTimeInterval()?.toHourMinuteString() ?? ""
        detailsTitle.append(time)
        return detailsTitle
    }

    func getDetailsAtributedContent() -> NSMutableAttributedString {
        let breakLine = NSAttributedString(string: "\n")
        let atributedTitles = details?.map({ return $0.getAtrributedTitle() })
        let title = NSMutableAttributedString(string: "")

        atributedTitles?.enumerated().forEach { (index, atributedString) in
            if index != 0 {
                title.append(breakLine)
            }
            title.append(atributedString)
        }
        return title
    }

    func getVideoDuration() -> Float {
        return Float(duration?.toTimeInterval() ?? 0)
    }
}

// MARK: ResolutionVideo
class ResolutionVideo: Codable {
    var _360p: String?
    var _480p: String?
    var _720p: String?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self._360p = try values.decode(String.self, forKey: ._360p)
        self._480p = try values.decode(String.self, forKey: ._480p)
        self._720p = try values.decode(String.self, forKey: ._720p)
    }
    
    enum CodingKeys: String, CodingKey {
        case _360p
        case _480p
        case _720p
    }
}

// MARK: CategoriesVideo
class CategoriesVideo: Codable {
    var id: Int?
    var name: String?
    var parentId, type, order, status: Int?
    var deletedAt: String?
    var createdAt, updatedAt: String?
    var pivot: PivotVideo?
    
    //new
    var slug: String?
    var description: String?
    //
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case parentId
        case type, order, status
        case deletedAt
        case createdAt
        case updatedAt
        case pivot
        case slug
        case description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.parentId = try? container.decode(Int.self, forKey: .parentId)
        self.type = try? container.decode(Int.self, forKey: .type)
        self.order = try? container.decode(Int.self, forKey: .order)
        self.status = try? container.decode(Int.self, forKey: .status)
        self.deletedAt = try? container.decode(String.self, forKey: .deletedAt)
        self.createdAt = try? container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.pivot = try? container.decode(PivotVideo.self, forKey: .pivot)
        self.slug = try? container.decode(String.self, forKey: .slug)
        self.description = try? container.decode(String.self, forKey: .updatedAt)
    }
}

// MARK: PivotVideo
class PivotVideo: Codable {
    var videoId, categoryId: Int?
    var modelId: Int?
    var positionId: Int?
    var modelType: String?
    
    enum CodingKeys: String, CodingKey {
        case videoId, categoryId
        case modelId, positionId, modelType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.videoId = try? container.decode(Int.self, forKey: .videoId)
        self.categoryId = try? container.decode(Int.self, forKey: .categoryId)
        
        self.modelId = try? container.decode(Int.self, forKey: .modelId)
        self.positionId = try? container.decode(Int.self, forKey: .positionId)
        self.modelType = try? container.decode(String.self, forKey: .modelType)
    }
}

//MARK: - PositionVideo
class PositionVideo: Codable {
    var id: Int?
    var name: String?
    var pivot: PivotVideo?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pivot
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.pivot = try? values.decode(PivotVideo.self, forKey: .pivot)
    }
}

//MARK: - CreatedVideo
class CreatedVideo: Codable {
    var id: Int?
    var userId: Int?
    var email: String?
    var username: String?
    var information: String?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var fullName: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case userId
        case email
        case username
        case information
        case createdAt
        case updatedAt
        case deletedAt
        case fullName
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.userId = try? values.decode(Int.self, forKey: .userId)
        self.email = try? values.decode(String.self, forKey: .email)
        self.username = try? values.decode(String.self, forKey: .username)
        self.information = try? values.decode(String.self, forKey: .information)
        self.createdAt = try? values.decode(String.self, forKey: .createdAt)
        self.updatedAt = try? values.decode(String.self, forKey: .updatedAt)
        self.deletedAt = try? values.decode(String.self, forKey: .deletedAt)
        self.fullName = try? values.decode(String.self, forKey: .fullName)
    }
}

//MARK: - HistoryVideo
class HistoryVideo: Codable {
    var id: Int?
    var videoId: Int?
    var userId: Int?
    var createdAt: String?
    var updatedAt: String?
    var lastSeenAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case videoId
        case userId
        case createdAt
        case updatedAt
        case lastSeenAt
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.videoId = try? values.decode(Int.self, forKey: .videoId)
        self.userId = try? values.decode(Int.self, forKey: .userId)
        self.createdAt = try? values.decode(String.self, forKey: .createdAt)
        self.updatedAt = try? values.decode(String.self, forKey: .updatedAt)
        self.lastSeenAt = try? values.decode(String.self, forKey: .lastSeenAt)
    }
}

//MARK: - PortalsVideo
class PortalsVideo: Codable {
    var id: Int?
    var name: String?
    var parentId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentId
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.parentId = try? values.decode(Int.self, forKey: .parentId)
    }
}

//MARK: - Segment Model
class SegmentVideo: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var startAt: String?
    var startTime: TimeInterval?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case startAt
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? values.decode(Int.self, forKey: .id)
        self.title = try? values.decode(String.self, forKey: .title)
        self.image = try? values.decode(String.self, forKey: .image)
        self.startAt = try? values.decode(String.self, forKey: .startAt)
        self.startTime = self.startAt?.toTimeInterval()
    }
}
