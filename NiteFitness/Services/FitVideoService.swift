//
//  FitVideoService.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation
import Alamofire

protocol FitVideoSeviceProtocol: AnyObject {
    
    func getVideoFeatured(page: Int, perPage: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    func getVideoSuggest(videoId: Int, categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    
    func getCategoryVideo(completion: @escaping ((Result<BaseModel<[CategoryFitModel]>, APIError>) -> Void))
    func getCategoriesVideo(completion: @escaping ((Result<BaseModel<CategoriesModel>, APIError>) -> Void))
    func getVideoByCategory(categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    
    func getVideoHistory(page: Int, perPage: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    func getRelatedVideo(videoId: Int, categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    
    
    func getVideoFavorite(completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void))
    func setAddFavorite(videoId: Int, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void))
    func setRemoveFavorite(videoId: Int, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void))
    
    func setTimeLastSeenVideo(videoId: Int, lastTime: String, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void))
    
    func getVideoDetail(slug: String, completion: @escaping ((Result<BaseModel<VideoModel>, APIError>) -> Void))
    func getVideoDetail(videoId: Int, completion: @escaping ((Result<BaseModel<VideoModel>, APIError>) -> Void))
}

//MARK: - FitVideoSeviceProtocol
class FitVideoService: FitVideoSeviceProtocol {
    private let service = BaseService.shared
    
    func getVideoFeatured(page: Int, perPage: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "page": page,
            "per_page": perPage,
            "popular": true,
            "is_featured": 1,
            "coach_id": "",
            "slug": "",
            "column": "created_at",
            "category_id": "",
            "sort": "DESC"
        ]
        let url = FitVideoServiceAPI.listVideoExercise.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getVideoSuggest(videoId: Int, categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "video_id": videoId,
            "category_id": categoryId,
            "type": "related"
        ]
        let url = FitVideoServiceAPI.relatedVideoExercise.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getCategoryVideo(completion: @escaping ((Result<BaseModel<[CategoryFitModel]>, APIError>) -> Void)) {
        let url = FitVideoServiceAPI.listCategoryVideoExercise.urlString
        self.service.GET(url: url, param: nil, completion: completion)
    }
    
    func getCategoriesVideo(completion: @escaping ((Result<BaseModel<CategoriesModel>, APIError>) -> Void)) {
        let url = FitVideoServiceAPI.categories.urlString
        self.service.GET(url: url, param: nil, completion: completion)
    }
    
    func getVideoByCategory(categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "page": 1,
            "per_page": 1000,
            "column": "created_at",
            "category_id": categoryId,
            "sort": "DESC"
        ]
        let url = FitVideoServiceAPI.listVideoExercise.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getVideoHistory(page: Int, perPage: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "page": page,
            "per_page": perPage,
            "order_type": "DESC"
        ]
        let url = FitVideoServiceAPI.videoUserHistory.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getRelatedVideo(videoId: Int, categoryId: Int, completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "video_id": videoId,
            "category_id": categoryId,
            "type": "related"
        ]
        let url = FitVideoServiceAPI.relatedVideoExercise.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getVideoFavorite(completion: @escaping ((Result<BaseModel<[VideoModel]>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "page": 1,
            "per_page": 1000
        ]
        let url = FitVideoServiceAPI.videoUserFavorite.urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func setAddFavorite(videoId: Int, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "video_id": videoId
        ]
        let url = FitVideoServiceAPI.videoUserFavorite.urlString
        self.service.POST(url: url, param: param, encoding: JSONEncoding.prettyPrinted, completion: completion)
    }
    
    func setRemoveFavorite(videoId: Int, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void)) {
        let url = FitVideoServiceAPI.removeFavoriteList(videoId).urlString
        self.service.DELETE(url: url, param: nil, completion: completion)
    }
    
    func setTimeLastSeenVideo(videoId: Int, lastTime: String, completion: @escaping ((Result<BaseModel<EmptyModel>, APIError>) -> Void)) {
        let param: [String: Any] = [
            "video_id": videoId,
            "last_seen_at": lastTime
        ]
        let url = FitVideoServiceAPI.lastSeen.urlString
        self.service.POST(url: url, param: param, encoding: JSONEncoding.prettyPrinted, completion: completion)
    }
    
    func getVideoDetail(slug: String, completion: @escaping ((Result<BaseModel<VideoModel>, APIError>) -> Void)) {
        let param = [
            SKKey.slug: slug
        ]
        let url = MediaServiceAPI.video(nil).urlString
        self.service.GET(url: url, param: param, completion: completion)
    }
    
    func getVideoDetail(videoId: Int, completion: @escaping ((Result<BaseModel<VideoModel>, APIError>) -> Void)) {
        let url = MediaServiceAPI.detailVideo(videoId).urlString
        self.service.GET(url: url, param: nil, completion: completion)
    }
}
