//
//  Date.swift
//  myElcom
//
//  Created by Tiến Trần on 29/07/2022.
//

import Foundation

import UIKit

// MARK: Date Format
extension Date {
    var calendar: Calendar {
        return Calendar(identifier: Calendar.Identifier.gregorian)
    }
    
    var nextHour: Date {
        return calendar.date(byAdding: .hour, value: 1, to: self) ?? self
    }

    var previousDay: Date {
        return calendar.date(byAdding: .day, value: -1, to: self)!.startOfDay
    }

    var nextDay: Date {
        return calendar.date(byAdding: .day, value: 1, to: self)!.startOfDay
    }
    
    var futureWeekDay: Date {
        return calendar.date(byAdding: .day, value: 13, to: self)!.startOfDay
    }

    var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }

    var endOfDay: Date {
        var component = DateComponents()
        component.hour = 23
        component.minute = 59
        component.second = 59
        return calendar.date(byAdding: component, to: startOfDay) ?? self
    }

    var startOfWeek: Date {
        let component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        let sunday = calendar.date(from: component)!
        return calendar.date(byAdding: .day, value: 0, to: sunday)!
    }

    var endOfWeek: Date {
        let component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        let sunday = calendar.date(from: component)!
        return calendar.date(byAdding: .day, value: 7, to: sunday)!.endOfDay
    }

    var nextWeek: Date {
        return calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek)!
    }

    var previousWeek: Date {
        return calendar.date(byAdding: .weekOfYear, value: -1, to: startOfWeek)!
    }

    var startOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }

    var endOfMonth: Date {
        let components = DateComponents(month: 1, day: -1)
        return self.startOfMonth.addComponent(components).endOfDay
    }

    var previousMonth: Date {
        return calendar.date(byAdding: .month, value: -1, to: startOfMonth)!
    }

    var nextMonth: Date {
        return calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
    }

    var startOfYear: Date {
        let components = calendar.dateComponents([.year], from: self)
        return calendar.date(from: components)!
    }

    var endOfYear: Date {
        var component = DateComponents()
        component.year = 1
        component.day = -1
        return calendar.date(byAdding: component, to: startOfYear)!.endOfDay
    }

    var previousYear: Date {
        return calendar.date(byAdding: .year, value: -1, to: startOfYear)!
    }

    var nextYear: Date {
        return calendar.date(byAdding: .year, value: 1, to: startOfYear)!
    }

    var year: Int {
        return calendar.component(.year, from: self)
    }

    var month: Int {
        return calendar.component(.month, from: self)
    }

    var weekDay: Int {
        return calendar.component(.weekday, from: self)
    }

    var day: Int {
        return calendar.component(.day, from: self)
    }

    var second: Int {
        return calendar.component(.second, from: self)
    }

    var minute: Int {
        return calendar.component(.minute, from: self)
    }

    var hour: Int {
        return calendar.component(.hour, from: self)
    }

    func isSameDay(with date: Date) -> Bool {
        return startOfDay == date.startOfDay
    }

    func isSameMonth(with date: Date) -> Bool {
        return year == date.year && month == date.month
    }

    func isSameHour(with date: Date) -> Bool {
        return isSameDay(with: date) && hour == date.hour
    }

    func addComponent(_ component: DateComponents) -> Date {
        return calendar.date(byAdding: component, to: self) ?? self
    }

    func monthBetween(with date: Date) -> Int {
        let component = calendar.dateComponents([.year, .month], from: self, to: date)
        return (component.year ?? 0) * 12 + (component.month ?? 0)
    }

    func yearBetween(with date: Date) -> Int {
        let component = calendar.dateComponents([.year], from: self, to: date)
        return component.year ?? 0
    }

    func toString(_ format: Format = .ymd) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format.rawValue
        dateFormater.locale = Locale(identifier: "vi")
//        return dateFormater.string(from: self)
        
        let text = dateFormater.string(from: self)
        return text.replaceCharacter(target: "Th", withString: "Thứ")
    }
    
    func toTimestamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" //"EEEE"
        dateFormatter.locale = Locale(identifier: "vi")
        return dateFormatter.string(from: self)//.capitalized
    }
    
    func dayOfWeek(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //"EEEE"
        dateFormatter.locale = Locale(identifier: "vi")
        return dateFormatter.string(from: self)//.capitalized
    }
    
    func currentWeekDates() -> [Date] {
        var listDate: [Date] = []
        for i in 0..<7 {
            if let day = Calendar.current.date(byAdding: .day, value: i, to: self.startOfWeek) {
                listDate.append(day)
            }
        }
        return listDate
    }
    
    func currentContinueWeekDates() -> [Date] {
        var listDate: [Date] = []
        for i in 0..<7 {
            if let day = Calendar.current.date(byAdding: .day, value: i, to: Date()) {
                listDate.append(day)
            }
        }
        return listDate
    }
    
    func nextWeekDates() -> [Date] {
        var listDate: [Date] = []
        for i in 0..<7 {
            if let day = Calendar.current.date(byAdding: .day, value: i, to: self.endOfWeek) {
                listDate.append(day)
            }
        }
        return listDate
    }

    func toPostCreateTimeFormat() -> String {
        var timeStringValue = ""
        let current = Date().timeIntervalSince1970
        let createTime = self.timeIntervalSince1970
        let duration = current - createTime
        switch duration {
        case ...60:
            timeStringValue = "Vừa xong"
        case ...3600:
            timeStringValue = "\(duration.intValue / 60) phút trước"
        case ...86400:
            timeStringValue = "\(duration.intValue / 3600) giờ trước"
        case ...604800:
            timeStringValue = "\(duration.intValue / 86400) ngày trước"
        case ...2_419_200:
            timeStringValue = "\(duration.intValue / 604800) tuần trước"
        case ...31_536_000:
            timeStringValue = "\(self.monthBetween(with: Date())) tháng trước"
        case 31_536_000...:
            timeStringValue = toString(.dmySlash)
        default:
            timeStringValue = ""
        }
        return "\(timeStringValue)"
    }

    enum Format: String {
        case ymd = "yyyy-MM-dd"
        case dmy = "dd-MM-yyyy"
        case hmsdMy = "HH:mm:SS dd-MM-yyyy"
        case hm = "HH:mm"
        case hms = "HH:mm:SS"
        case hma = "HH:mm a"
        case h = "HH"
        case m = "mm"
        case dmyhms = "dd-MM-yyyy HH:mm:SS"
        case hmdmy = "HH:mm dd/MM/yyyy"
        case ms = "m:SS"
        case dmySlash = "dd/MM/yyyy"
        case ymdSlash = "yyyy/MM/dd"
        case ymdhms = "yyyy-MM-dd HH:mm:SS"
        case ymdThmsZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case eeedmySlash = "EEE, dd/MM/yyyy"
        case eeeedmySlash = "EEEE, dd/MM/yyyy"
        case eee = "EEE"
        case eeee = "EEEE"
    }

}

// MARK: Date Component
extension Date {
    static var yesterday: Date {
        return Date().dayBefore
    }
    
    static var tomorrow: Date {
        return Date().dayAfter
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var toDay: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }
    
    var monthBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -30, to: noon)!
    }
    
    var yearBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -365, to: noon)!
    }
    
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "HH:mm"
        
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    func dateStringWith(_ strFormat: Format = .hma) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat.rawValue
        
        return dateFormatter.string(from: self)
    }
}

// MARK: TimeInterval
extension TimeInterval {
    func toTimeFormat() -> String? {
        let formater = DateComponentsFormatter()
        formater.zeroFormattingBehavior = .pad
        formater.allowedUnits = [.minute, .second]
        if self > 3600 {
            formater.allowedUnits.insert(.hour)
        }
        return formater.string(from: self)
    }
}

// MARK: ISO8601DateFormatter
extension Date {
    init(dateString: String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }

    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        return formatter
    }()
}
