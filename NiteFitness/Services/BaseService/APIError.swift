//
//  APIError.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

struct APIError: Error, Codable, CustomStringConvertible {
    var message: String
    var statusCode: Int

    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }

    var description: String {
        return "<APIError> code: \(statusCode), message: \(message)"
    }
}
