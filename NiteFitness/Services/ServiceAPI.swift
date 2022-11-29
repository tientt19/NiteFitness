//
//  ServiceAPis.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

// MARK: - AuthServiceAPI
enum AuthServiceAPI: AuthServiceUrlProtocol {
    case loginWithGoogle
    case login
    case appleLogin
    case profile
    case logout
    case changePassword
    case onesignal
    case signUp
    case deleteAccount

    var path: String {
        switch self {
        case .loginWithGoogle:
            return "google/callback"
            
        case .profile:
            return "staff/profile"
            
        case .login:
            return "login"
            
        case .logout:
            return "logout"
            
        case .changePassword:
            return "staff/change-password"
            
        case .onesignal:
            return "onesignal/user-hash"
            
        case .appleLogin:
            return "apple/login"
            
        case .signUp:
            return "register"
            
        case .deleteAccount:
            return "user/delete"
        }
    }
}

//MARK: - NewFeedServiceAPI {
enum NewFeedServiceAPI: NewFeedServiceUrlProtocol {
    case homeFeed
    case homeFeedDetail(Int)
    
    var path: String {
        switch self {
        case .homeFeed:
            return "news"
            
        case .homeFeedDetail(let id):
            return "news/\(id)"
        }
    }
}

//MARK: - StaffManagerServiceUrlProtocol
enum StaffServiceAPI: StaffManagerServiceUrlProtocol {
    case StaffList
    case outsideOffices
    case outsideOfficeRegister
    case addStaff
    case removeStaff(Int)
    case removeStaffManagement
    case leaveOffice

    var path: String {
        switch self {
        case .StaffList:
            return "staffs"
            
        case .outsideOffices:
            return "outside-offices"
            
        case .outsideOfficeRegister:
            return "outside-office"
            
        case .addStaff:
            return "add-staff"
            
        case .removeStaff(let id):
            return "staff/delete/\(id)"
            
        case .removeStaffManagement:
            return "remove-staff"
            
        case .leaveOffice:
            return "ep/leave-office"
        }
    }
}


//MARK: - StaffManagerServiceUrlProtocol
enum LeavaOfficeServiceAPI: LeaveOfficeServiceUrlProtocol {
    case outsideOffices
    case delete(Int)
    case outsideOfficeApprove(Int)
    case outsideOfficeShowDetail(Int)
    
    var path: String {
        switch self {
        case .outsideOffices:
            return "outside-offices"
            
        case .delete(let id):
            return "outside-office/delete/\(id)"
            
        case .outsideOfficeApprove(let id):
            return "outside-office/approve/\(id)"
            
        case .outsideOfficeShowDetail(let id):
            return "outside-office/show/\(id)"
        }
    }
}
    
//MARK: -NotificationServiceAPI
enum NotificationServiceAPI: LeaveOfficeServiceUrlProtocol {
    case userNoti
    case notiDetail(Int)
    
    var path: String {
        switch self {
        case .userNoti:
            return "onesignal/user-noti"
            
        case .notiDetail(let id):
            return "outside-office/approve/\(id)"
        }
    }
}

// MARK: - WordPressServiceAPI
enum WordPressServiceAPI: WordPressServiceUrlProtocol {
    case posts
    case postsId(Int)
    case popularPosts
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
            
        case .postsId(let id):
            return "posts/\(id)"
            
        case .popularPosts:
            return "popularPosts"
        }
    }
}

//MARK: - FitVideoServiceAPI
enum FitVideoServiceAPI: FitServiceUrlProtocol {
    case listVideoExercise
    case relatedVideoExercise
    case listCategoryVideoExercise
    case historyVideoExercise
    case likedVideoExercise
    case videoUserHistory
    case videoUserFavorite
    case removeFavoriteList(Int)
    case lastSeen
    case categories
    
    var path: String {
        switch self {
        case .listVideoExercise:
            return "media/videos"
        case .relatedVideoExercise:
            return "media/video/related"
        case .historyVideoExercise:
            return "media/video-user-history"
        case .likedVideoExercise:
            return "media/video-user-favourite"
        case .listCategoryVideoExercise:
            return "media/category"
        case .videoUserHistory:
            return "media/video-user-history"
        case .videoUserFavorite:
            return "media/video-user-favourite"
        case .removeFavoriteList(let id):
            return "media/video-user-favourite/\(id)"
        case .lastSeen:
            return "media/video-user-history/last-seen"
        case .categories:
            return "config/categories?slug=video-tap-luyen"
        }
    }
}

enum MediaServiceAPI: FitnessServiceUrlProtocol {
    case attribute
    case category
    case topic(String?)
    case coach(String?)
    case video(Int?)
    case detailVideo(Int?)
    case relatedVideo
    case videoUserHistory
    case videos

    var path: String {
        switch self {
        case .attribute:
            return "media/attribute"
        case .category:
            return "media/category"
        case .topic(let id):
            return "media/topic\(id.toURLPath())"
        case .coach(let id):
            return "fitness/coach\(id.toURLPath())"
        case .video(let id):
            let url: String? = String(id ?? -1) == "-1" ? nil : String(id ?? -1)
            return "media/videos\(url.toURLPath())"
        case .detailVideo(let id):
            let url: String? = String(id ?? -1) == "-1" ? nil : String(id ?? -1)
            return "media/video\(url.toURLPath())"
        case .relatedVideo:
            return "media/video/related"
        case .videoUserHistory:
            return "media/video-user-history"
        case .videos:
            return "media/videos"
        }
    }
}
