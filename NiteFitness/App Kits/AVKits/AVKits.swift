//
//  AVKits.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//


import Foundation
import UIKit
import AVKit

enum DeviceOrientation {
    case portrait
    case landscape
}

enum TrackState {
    case error
    case loading
    case readyToPlay
    case seeking
    case playedToTheEnd
}

struct Track {
    var playerItem: AVPlayerItem
    var index: Int
    var state: TrackState

    init(url: URL, index: Int) {
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        self.playerItem = item
        self.index = index
        self.state = .loading
    }
}

struct AVConstant {
    static let loadedTimeRangesKey = "loadedTimeRanges"
    static let rate = "rate"
    static let duration = "duration"
}

class AVUtils {
    private struct UtilsConstant {
        static let countTimeFormat = "%02d:%02d"
        static let countTimeFormatWithHour = "%02d:%02d:%02d"
        static let secondsPerHour = 3600
        static let secondsPerMinute = 60
        static let milisecondsPerSecond = 1000
    }

    static func getDeviceOrientation(screenSize: CGSize = UIScreen.main.bounds.size) -> DeviceOrientation {
        return screenSize.width < screenSize.height ? .portrait : .landscape
    }

    static func formatDurationTime(time: Int) -> String {
        var tmpTime = time
        let hours = tmpTime / UtilsConstant.secondsPerHour
        tmpTime -= hours * UtilsConstant.secondsPerHour
        let minutes = tmpTime / UtilsConstant.secondsPerMinute
        tmpTime -= minutes * UtilsConstant.secondsPerMinute
        let seconds = tmpTime
        if hours <= 0 {
            return String(format: UtilsConstant.countTimeFormat, minutes, seconds)
        } else {
            return String(format: UtilsConstant.countTimeFormatWithHour, hours, minutes, seconds)
        }
    }
    
    static func getFormatTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
            
        } else {
            return String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return self.rate != 0 && self.error == nil
    }
}

extension AVAsset {
    var videoSize: CGSize? {
        tracks(withMediaType: .video).first.flatMap {
            tracks.count > 0 ? $0.naturalSize.applying($0.preferredTransform) : nil
        }
    }
}

extension AVPlayerItem {
    public func totalBuffer() -> Double {
        return self.loadedTimeRanges
            .map({ $0.timeRangeValue })
            .reduce(0, { acc, cur in
                return acc + CMTimeGetSeconds(cur.start) + CMTimeGetSeconds(cur.duration)
            })
    }

    public func currentBuffer() -> Double {
        let currentTime = self.currentTime()

        guard let timeRange = self.loadedTimeRanges.map({ $0.timeRangeValue })
            .first(where: { $0.containsTime(currentTime) }) else { return -1 }

        return CMTimeGetSeconds(timeRange.end) - currentTime.seconds
    }

}
