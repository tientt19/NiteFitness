//
//  GenderModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

enum Gender: Int, Codable {
    case male
    case female
    case other

    var id: Int {
        switch self {
        case .male:
            return 0
        case .female:
            return 1
        case .other:
            return 2
        }
    }
    
    var valueVi: String {
        switch self {
        case .male:
            return "Nam"
        case .female:
            return "Nữ"
        case .other:
            return "Khác"
        }
    }
    
    var param: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        case .other:
            return "other"
        }
    }
}
