//
//  AppShare.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class AppShare: NSObject {
    var fitnessWorkout: AnalyticsShare?
    var fitnessVideo: AnalyticsShare?
    var fitnessPost: AnalyticsShare?
    
    var careDoctor: AnalyticsShare?
    var careVideo: AnalyticsShare?
    var carePost: AnalyticsShare?
    
    override init() {
        self.fitnessWorkout = AnalyticsShare()
        self.fitnessVideo = AnalyticsShare()
        self.fitnessPost = AnalyticsShare()
        
        self.careDoctor = AnalyticsShare()
        self.careVideo = AnalyticsShare()
        self.carePost = AnalyticsShare()
    }
}

class MetaSocialShare: NSObject {
    var socialMetaTitle: String?
    var socialMetaDescText: String?
    var socialMetaImageURL: String?
    
    var analytics: AnalyticsShare?
}

class AnalyticsShare: NSObject {
    var itunesProviderToken: String?
    var itunesCampaignToken: String?
    
    var analyticsSource: String?
    var analyticsMedium: String?
    var analyticsCampaign: String?
    
    var isRequired: Bool?
}

