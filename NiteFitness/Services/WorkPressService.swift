//
//  WorkPressService.swift
//  NiteFitness
//
//  Created by Tiến Trần on 28/11/2022.
//

import Foundation

protocol WorkPressServiceProtocol {
    func getHealthyLivingPosts(of type: HealthyLivingFilterType, page: Int, perPage: Int, completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void))
    func getHealthyLivingPopularPosts(completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void))
    func getHealthyLiving(with postId: Int, completion: @escaping ((Result<PostHealthModel, APIError>) -> Void))
    func getHomeHealthPosts(completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void))
}

//MARK: - WorkPressServiceProtocol
class WorkPressService: WorkPressServiceProtocol {
    private let service = BaseService.shared

    func getHealthyLivingPosts(of type: HealthyLivingFilterType, page: Int, perPage: Int, completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void)) {
        var params: [String: Any] = [
            "orderby": "date",
            "order": "desc",
            "page": page,
            "per_page": perPage
        ]
        if type != .all {
            params["categories[]"] = type.typeId
        }
        
        //let url = "https://1sk.vn/song-khoe/wp-json/wp/v2/posts"
        let url = WordPressServiceAPI.posts.urlString
        self.service.GET_WP(url: url, param: params, completion: completion)
    }
    
    func getHealthyLivingPopularPosts(completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void)) {
        let params: [String: Any] = [
            "orderby": "date",
            "order": "desc"
        ]
        
        let url = "https://1sk.vn/song-khoe/wp-json/jnews/v1/popularPosts"
        //let url = WordPressServiceAPI.popularPosts.urlString
        self.service.GET_WP(url: url, param: params, completion: completion)
    }
    
    func getHealthyLiving(with postId: Int, completion: @escaping ((Result<PostHealthModel, APIError>) -> Void)) {
        //let url = "https://1sk.vn/song-khoe/wp-json/wp/v2/posts/\(postId)"
        let url = WordPressServiceAPI.postsId(postId).urlString
        self.service.GET_WP(url: url, param: nil, completion: completion)
    }
    
    func getHomeHealthPosts(completion: @escaping ((Result<[PostHealthModel], APIError>) -> Void)) {
        //let url = "https://1sk.vn/song-khoe/wp-json/wp/v2/posts"
        let url = WordPressServiceAPI.posts.urlString
        self.service.GET_WP(url: url, param: nil, completion: completion)
    }
}
