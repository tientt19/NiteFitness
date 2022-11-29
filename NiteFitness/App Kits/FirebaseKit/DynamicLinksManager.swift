//
//  DynamicLinksManager.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation
import FirebaseDynamicLinks

enum ShareType: String {
    case blog = "01"
    case video = "02"
    case doctor = "03"
    case workout = "04"
    case virtualRace = "05"
}

class DynamicLinksManager {
    static let shared = DynamicLinksManager()
    
    func createDynamicLinksShare(meta: MetaSocialShare, universalLink: String) -> DynamicLinkComponents? {
        guard let link = URL(string: universalLink) else { return nil }
        print("createDynamicLinksShare universalLink:", universalLink)
        
        //let dynamicLinksDomainURIPrefix = "https://dynamic-links.1sk.vn"
        let dynamicLinksDomainURIPrefix = "https://app.1sk.vn"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = meta.socialMetaTitle ?? "1SK - Sức khỏe là số 1!"
        linkBuilder?.socialMetaTagParameters?.descriptionText = meta.socialMetaDescText ?? "1SK - Sức khỏe là số 1!"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: meta.socialMetaImageURL ?? "")
        
        print("createDynamicLinksShare meta title:", linkBuilder?.socialMetaTagParameters?.title ?? "nil")
        print("createDynamicLinksShare meta descriptionText:", linkBuilder?.socialMetaTagParameters?.descriptionText ?? "nil")
        print("createDynamicLinksShare meta imageURL:", linkBuilder?.socialMetaTagParameters?.imageURL ?? "nil")
        
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: gAppLinks.appIosBundleID!)
        linkBuilder?.iOSParameters?.appStoreID = gAppLinks.appIosStoreID!
        linkBuilder?.iOSParameters?.minimumAppVersion = gAppLinks.appIosMinVersion!
        
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: gAppLinks.appAndroidPackageName!)
        linkBuilder?.androidParameters?.minimumVersion = gAppLinks.appAndroidMinVersion!
        linkBuilder?.androidParameters?.fallbackURL = URL(string: gAppLinks.appAndroidStoreURL!)

        if meta.analytics?.isRequired == true {
            linkBuilder?.analyticsParameters = DynamicLinkGoogleAnalyticsParameters()
            if let source = meta.analytics?.analyticsSource {
                linkBuilder?.analyticsParameters?.source = source
            }
            if let medium = meta.analytics?.analyticsMedium {
                linkBuilder?.analyticsParameters?.medium = medium
            }
            if let campaign = meta.analytics?.analyticsCampaign {
                linkBuilder?.analyticsParameters?.campaign = campaign
            }

            linkBuilder?.iTunesConnectParameters = DynamicLinkItunesConnectAnalyticsParameters()
            if let providerToken = meta.analytics?.itunesProviderToken {
                linkBuilder?.iTunesConnectParameters?.providerToken = providerToken
            }
            if let campaign = meta.analytics?.itunesCampaignToken {
                linkBuilder?.iTunesConnectParameters?.campaignToken = campaign
            }
        }
        
        linkBuilder?.options = DynamicLinkComponentsOptions()
        linkBuilder?.options?.pathLength = .short
        
//        if let longURL = linkBuilder?.url {
//            print("createDynamicLinksShare absoluteString:", longURL.absoluteString)
//        }
        
        return linkBuilder
    }
    
    func createDynamicLinksShareDemo(meta: MetaSocialShare, linkShare: String) {
        guard let link = URL(string: linkShare) else { return }
        let dynamicLinksDomainURIPrefix = "https://app.1sk.vn"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.elcom.OneSK")
        linkBuilder?.iOSParameters?.appStoreID = "1554801349"
        linkBuilder?.iOSParameters?.minimumAppVersion = "1.0.6"
        //linkBuilder?.iOSParameters?.fallbackURL = URL(string: "https://apps.apple.com/us/app/1sk/id1554801349")
        
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "vn.onesk")
        linkBuilder?.androidParameters?.minimumVersion = 6
        linkBuilder?.androidParameters?.fallbackURL = URL(string: "https://play.google.com/store/apps/details?id=vn.onesk")
        
        
        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "Example of a Dynamic Link"
        linkBuilder?.socialMetaTagParameters?.descriptionText = "This link works whether the app is installed or not!"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "https://c7ccf637e7c1535.cmccloud.com.vn/v1.0/upload/fitness/thumb_image_files/11012022/MPiKpCvRhJXaqIgPbQThEMG8qYB6v791iMvwa9GO.jpg"    )
        
        print("createDynamicLinksShareDemo meta title:", linkBuilder?.socialMetaTagParameters?.title ?? "nil")
        print("createDynamicLinksShareDemo meta descriptionText:", linkBuilder?.socialMetaTagParameters?.descriptionText ?? "nil")
        print("createDynamicLinksShareDemo meta imageURL:", linkBuilder?.socialMetaTagParameters?.imageURL ?? "nil")
        
        linkBuilder?.options = DynamicLinkComponentsOptions()
        linkBuilder?.options?.pathLength = .short
        
        if let longURL = linkBuilder?.url {
            print("createDynamicLinksShareDemo absoluteString:", longURL.absoluteString)
        }
        
        linkBuilder?.shorten(completion: { url, warnings, error in
            if let listWarning = warnings {
                for (index, warning) in listWarning.enumerated() {
                    print("createDynamicLinksShareDemo warning: \(index) - \(warning)")
                }
            }

            if let err = error {
                SKToast.shared.showToast(content: "Chức năng chưa hoạt động")
                print("createDynamicLinksShareDemo error: \(err.localizedDescription)")
                return
            }

            guard let urlShare = url else {
                SKToast.shared.showToast(content: "Chức năng chưa hoạt động")
                print("createDynamicLinksShareDemo url: nil")
                return
            }
            
            print("createDynamicLinksShareDemo The short URL is: \(urlShare)")
        })
    }
}

