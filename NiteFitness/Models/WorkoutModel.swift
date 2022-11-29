//
//  WorkoutModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class WorkoutModel: Codable {
    
    var userId: Int?
    var name: String?
    var timeBreak: Int?
    var isTemplate: Int?
    var status: Int?
    var id: Int?
    var details: [WorkoutDetailModel]?
    var time: Int?
    var userName: String?
    var finish: Int?
    var userAvatar: String?
    var fullName: String?
    var isBookmark: Int?
    var timeStart: String?
    var timePractice: String?
    var rate: Int?
    var music: MusicModel?
    
    var subject: SubjectModel?
    var level: LevelModel?
    var type: TypeModel?
    
    enum CodingKeys: String, CodingKey {
        case userName
        case details
        case subject
        case name
        case finish
        case level
        case isTemplate
        case id
        case type
        case userId
        case time
        case status
        case timeBreak
        case isBookmark
        case music
        case fullName
        case userAvatar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(TypeModel.self, forKey: .type)
        self.userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.timeBreak = try container.decodeIfPresent(Int.self, forKey: .timeBreak)
        self.isTemplate = try container.decodeIfPresent(Int.self, forKey: .isTemplate)
        self.subject = try container.decodeIfPresent(SubjectModel.self, forKey: .subject)
        self.level = try container.decodeIfPresent(LevelModel.self, forKey: .level)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.details = try container.decodeIfPresent([WorkoutDetailModel].self, forKey: .details)
        self.time = try container.decodeIfPresent(Int.self, forKey: .time)
        self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
        self.finish = try container.decodeIfPresent(Int.self, forKey: .finish)
        self.music = try container.decodeIfPresent(MusicModel.self, forKey: .music)
        self.isBookmark = try container.decodeIfPresent(Int.self, forKey: .isBookmark)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.userAvatar = try container.decodeIfPresent(String.self, forKey: .userAvatar)
    }

    func getDetailsContent() -> String {
        var detailsTitle = ""
        detailsTitle.append(time?.doubleValue.getTimeString() ?? "")
        detailsTitle.append(" • ")
        detailsTitle.append("\(self.details?.count ?? 0) động tác")
        return detailsTitle
    }
}

class WorkoutDetailModel: Codable {
    var order: Int?
    var exercise: ExerciseModel?
    var time: Int?
    var id: Int?
    
    var subject: SubjectModel?
    var level: LevelModel?
    var type: TypeModel?
    
    enum CodingKeys: String, CodingKey {
        case order
        case exercise
        case time
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.order = try? container.decodeIfPresent(Int.self, forKey: .order)
        self.exercise = try? container.decodeIfPresent(ExerciseModel.self, forKey: .exercise)
        self.time = try? container.decodeIfPresent(Int.self, forKey: .time)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
    }
}

class SubjectModel: WorkoutItemProtocol, Codable {
    
    var id: Int
    var name: String
    var order: Int?
    var status: Int?
    var createdBy: Int?
    var showActivity: Int?
    var type: Int?
    var showWorkout: Int?
    var isSelected: Bool?
    var lastId: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, order, status
        case createdBy
        case showActivity
        case showWorkout
        case lastId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decodeIfPresent(Int.self, forKey: .order)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? Int()
        createdBy = try container.decodeIfPresent(Int.self, forKey: .createdBy)
        showActivity = try container.decodeIfPresent(Int.self, forKey: .showActivity)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        type = try container.decodeIfPresent(Int.self, forKey: .type)
        showWorkout = try container.decodeIfPresent(Int.self, forKey: .showWorkout)
        self.lastId = try container.decodeIfPresent(String.self, forKey: .lastId)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

class LevelModel: SubjectModel {
    
}

class TypeModel: SubjectModel {
}

class ToolModel: SubjectModel {
}

class ExerciseModel: Codable {
    
    var typeDisplay: Int?
    var image: String?
    var videoMovementDuration: Int?
    var movementSize: Int?
    var time: Int?
    var typeVideo: Int?
    var movement: String?
    var id: Int?
    var name: String?
    var movementM3u8: String?
    var status: Int?
    var video: String?
    var typeMovement: Int?
    
    var tools: [ToolModel]?
    var level: LevelModel?
    var description: String?
    var type: TypeModel?
    var subject: SubjectModel?
    var filters: [FilterModel]?
    
    var videoName: String?
    var videoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case tools
        case level
        case typeDisplay
        case image
        case videoMovementDuration
        case movementSize
        case time
        case typeVideo
        case movement
        case id
        case name
        case movementM3u8
        case status
        case video
        case description
        case typeMovement
        case filters
        case subject
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        typeDisplay = try container.decodeIfPresent(Int.self, forKey: .typeDisplay)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        videoMovementDuration = try container.decodeIfPresent(Int.self, forKey: .videoMovementDuration)
        movementSize = try container.decodeIfPresent(Int.self, forKey: .movementSize)
        time = try container.decodeIfPresent(Int.self, forKey: .time)
        typeVideo = try container.decodeIfPresent(Int.self, forKey: .typeVideo)
        movement = try container.decodeIfPresent(String.self, forKey: .movement)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        movementM3u8 = try container.decodeIfPresent(String.self, forKey: .movementM3u8)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        video = try container.decodeIfPresent(String.self, forKey: .video)
        typeMovement = try container.decodeIfPresent(Int.self, forKey: .typeMovement)
        self.subject = try container.decodeIfPresent(SubjectModel.self, forKey: .subject)
        self.filters = try container.decodeIfPresent([FilterModel].self, forKey: .filters)
        self.type = try container.decodeIfPresent(TypeModel.self, forKey: .type)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.tools = try container.decodeIfPresent([ToolModel].self, forKey: .tools)
        self.level = try container.decodeIfPresent(LevelModel.self, forKey: .level)
    }
}

class FilterModel: WorkoutItemProtocol, Codable {
    var id: Int
    var name: String
    var parentId: Int
    var status: Int?
    var order: Int?
    var item: [ValuesModel]?
}

enum Option: String {
    case subject
    case level
    case type
}

enum TypeDisplay: Int {
    case time = 0
    case number = 1
}

class ValuesModel: Codable {
    var id: Int?
    var name: String?
    var isSelected: Bool?
    
    convenience init() {
        self.init(id: -1, name: "", isSelected: false)
    }
    
    init(id: Int, name: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
