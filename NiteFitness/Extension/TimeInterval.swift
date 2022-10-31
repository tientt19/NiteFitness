//
//  TimeInterval.swift
//  myElcom
//
//  Created by Tiến Trần on 29/07/2022.
//

import Foundation

extension TimeInterval {
    var asTimeFormat: String {
        return String(format: "%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))))
    }
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
      formatter.unitsStyle = style
      return formatter.string(from: self) ?? ""
    }
}
