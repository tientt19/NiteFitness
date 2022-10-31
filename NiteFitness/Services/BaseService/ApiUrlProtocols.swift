//
//  ApiUrlProtocols.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

// MARK: ApiUrlProtocol
protocol ApiUrlProtocol {
    var path: String { get }
    var fullURLString: String { get }
    var urlString: String { get }
    var url: URL! { get }
}

extension ApiUrlProtocol {
    var fullURLString: String {
        return String(format: "%@/%@", BASE_URL, path)
    }
    
    var urlString: String {
        return String(format: "%@/%@", FITNESS_SERVICE_URL, self.path)
    }

    var url: URL! {
        return URL(string: self.fullURLString)
    }
}

// MARK: AuthServiceUrlProtocol
protocol AuthServiceUrlProtocol {
    var path: String { get }
    var urlString: String { get }
    var url: URL! { get }
}

extension AuthServiceUrlProtocol {
    var urlString: String {
        return String(format: "%@/%@", AUTH_SERVICE_URL, self.path)
    }

    var url: URL! {
        return URL(string: self.urlString)
    }
}

//MARK: - NewFeedServiceUrlProtocol
protocol NewFeedServiceUrlProtocol {
    var path: String { get }
    var urlString: String { get }
    var url: URL! { get }
}

extension NewFeedServiceUrlProtocol {
    var urlString: String {
        return String(format: "%@/%@", NEWFEED_SERVICEE_URL, self.path)
    }

    var url: URL! {
        return URL(string: self.urlString)
    }
}

//MARK: - StaffManagerServiceUrlProtocol
protocol StaffManagerServiceUrlProtocol {
    var path: String { get }
    var urlString: String { get }
    var url: URL! { get }
}

extension StaffManagerServiceUrlProtocol {
    var urlString: String {
        return String(format: "%@/%@", BASE_URL, self.path)
    }

    var url: URL! {
        return URL(string: self.urlString)
    }
}

//MARK: - LeaveOfficeServiceUrlProtocol
protocol LeaveOfficeServiceUrlProtocol {
    var path: String { get }
    var urlString: String { get }
    var url: URL! { get }
}

extension LeaveOfficeServiceUrlProtocol {
    var urlString: String {
        return String(format: "%@/%@", BASE_URL, self.path)
    }

    var url: URL! {
        return URL(string: self.urlString)
    }
}
