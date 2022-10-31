//
//  Error.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

extension Error {
    var errorCode: Int? {
        return (self as NSError).code
    }
}
