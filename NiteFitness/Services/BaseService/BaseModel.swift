//
//  BaseModel.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

// MARK: BaseModel
class BaseModel<T: Codable>: Codable {
    var status: Int?
    var message: String?
    var total: Int?
    
    var meta: Meta?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case total
        case meta
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
        self.meta = try? container.decodeIfPresent(Meta.self, forKey: .meta)
        self.data = try? container.decodeIfPresent(T.self, forKey: .data)
        self.total = try? container.decodeIfPresent(Int.self, forKey: .total)
    }
}

// MARK: Meta
class Meta: Codable {
    var message: String?
    var pagination: Pagination?
    var total: Int?
    var code: Int?
    var requestTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case pagination
        case total
        case code
        case requestTime
    }
    
    init (message: String?, pagination: Pagination?, total: Int?, code: Int?) {
        self.message = message
        self.pagination = pagination
        self.total = total
        self.code = code
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
        self.pagination = try? container.decodeIfPresent(Pagination.self, forKey: .pagination)
        self.total = try? container.decodeIfPresent(Int.self, forKey: .total)
        self.code = try? container.decodeIfPresent(Int.self, forKey: .code)
        self.requestTime = try? container.decodeIfPresent(Int.self, forKey: .requestTime)
        
        if let timeSystem = try? container.decodeIfPresent(Int.self, forKey: .requestTime) {
            gTimeSystem = timeSystem
        }
    }
    
}

// MARK: Links
class Links: Codable {
    var next: String?
    
    enum CodingKeys: String, CodingKey {
        case next
    }
    
    init (next: String?) {
        self.next = next
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.next = try? container.decodeIfPresent(String.self, forKey: .next)
    }
}

// MARK: Pagination
class Pagination: Codable {
    var count: Int?
    var currentPage: Int?
    var totalPages: Int?
    var perPage: Int?
    var total: Int?
    var links: Links?
    
    enum CodingKeys: String, CodingKey {
        case count
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case total
        case links
    }
    
    init (count: Int?, currentPage: Int?, totalPages: Int?, perPage: Int?, total: Int?, links: Links?) {
        self.count = count
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.perPage = perPage
        self.total = total
        self.links = links
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try? container.decodeIfPresent(Int.self, forKey: .count)
        self.currentPage = try? container.decodeIfPresent(Int.self, forKey: .currentPage)
        self.totalPages = try? container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.perPage = try? container.decodeIfPresent(Int.self, forKey: .perPage)
        self.total = try? container.decodeIfPresent(Int.self, forKey: .total)
        self.links = try? container.decodeIfPresent(Links.self, forKey: .links)
    }
}

