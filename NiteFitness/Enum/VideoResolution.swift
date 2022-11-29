//
//  VideoResolution.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import UIKit

enum VideoResolution: CaseIterable {
    case auto
    case _1080
    case _720
    case _480
    case _360

    var name: String {
        switch self {
        case .auto:
            return "Tự động"
        case ._1080:
            return "1080p"
        case ._720:
            return "720p"
        case ._480:
            return "480p"
        case ._360:
            return "360p"
        }
    }

    var bitrate: Double {
        switch self {
        case .auto:
            return 0
        case ._1080:
            return 6_000_000
        case ._720:
            return 4_000_000
        case ._480:
            return 2_000_000
        case ._360:
            return 1_500_000
        }
    }

    var resolution: CGSize {
        switch self {
        case .auto:
            return .zero
        case ._1080:
            return CGSize(width: 1920, height: 1080)
        case ._720:
            return CGSize(width: 1280, height: 720)
        case ._480:
            return CGSize(width: 858, height: 480)
        case ._360:
            return CGSize(width: 480, height: 360)
        }
    }
}

public extension CaseIterable where Self: Equatable {

    func ordinal() -> Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }

}

