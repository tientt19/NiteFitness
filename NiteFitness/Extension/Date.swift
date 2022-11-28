//
//  Date+Extension.swift
//  1SK
//
//  Created by tuyenvx on 9/30/20.
//

import UIKit

extension Date {
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    var isInThisYear: Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek: Bool { isInSameWeek(as: Date()) }
    
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday: Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow: Bool { Calendar.current.isDateInTomorrow(self) }
    
    var isInTheFuture: Bool { self > Date() }
    var isInThePast: Bool { self < Date() }
}

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
        return calendar.date(byAdding: .day, value: 1, to: sunday)!
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
        return dateFormater.string(from: self)
    }

    func toStringReplace(_ format: Format = .ymd) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format.rawValue
        dateFormater.locale = Locale(identifier: "vi")
        //return dateFormater.string(from: self)

        let text = dateFormater.string(from: self)
        return text.replaceCharacter(target: "Th", withString: "Thứ")
    }
    
    func toInt(_ format: Format = .ymd) -> Int? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format.rawValue
        dateFormater.locale = Locale(identifier: "vi")
        return Int(dateFormater.string(from: self))
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
            timeStringValue = self.toStringReplace(.dmySlash)
        default:
            timeStringValue = ""
        }
        return "\(timeStringValue)"
    }

    func age() -> Int {
        var ageComponents: DateComponents!
        if #available(iOS 15, *) {
            ageComponents = calendar.dateComponents([.year], from: self, to: .now)
        } else {
            ageComponents = calendar.dateComponents([.year], from: self, to: Date())
        }
        return ageComponents.year!
    }
    
    enum Format: String {
        case ymd = "yyyy-MM-dd"
        case dmy = "dd-MM-yyyy"
        case hmsdMy = "HH:mm:SS dd-MM-yyyy"
        case hm = "HH:mm"
        case hms = "HH:mm:SS"
        case h = "HH"
        case m = "mm"
        case dmyhms = "dd-MM-yyyy HH:mm:SS"
        case dmyhmsSlash = "dd/MM/yyyy HH:mm:ss"
        case hmdmy = "HH:mm dd/MM/yyyy"
        case ms = "m:SS"
        case dmySlash = "dd/MM/yyyy"
        case ymdSlash = "yyyy/MM/dd"
        case mySlash = "MM/yyyy"
        case ymdSlashhms = "yyyy/MM/dd HH:mm:SS"
        case ymdhms = "yyyy-MM-dd HH:mm:ss"
        case ymdThmsZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case ymdThms = "yyyy-MM-dd'T'HH:mm:ss"
        case eeedmySlash = "EEE, dd/MM/yyyy"
        case eeeedmySlash = "EEEE, dd/MM/yyyy"
        case eee = "EEE"
        case eeee = "EEEE"
        case ymdhm = "yyyy-MM-dd HH:mm"
        
        case dd = "dd"
        case MM = "MM"
        case YYYY = "YYYY"
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
    
    var dayCurrent: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: begin)!
    }
    
    var toDay: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: begin)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var begin: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }
    
    var weekAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: noon)!
    }
    
    var monthBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -15, to: noon)!
    }
    
    var monthAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 45, to: noon)!
    }
    
    var yearBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -182, to: noon)!
    }
    
    var yearAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 547, to: noon)!
    }
    
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var startOfWeekCurrent: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeekCurrent: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var startOfMonthCurrent: Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }

    var endOfMonthCurrent: Date? {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonthCurrent ?? Date())
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
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
    
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
    
    func asTimeFormat(_ isFullFormat: Bool = false) -> String {
        let seconds = Int(self)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        let second = ((seconds % 3600) % 60)
        if isFullFormat {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if hour == 0 {
            return String(format: "%02d:%02d", minute, second)
        }
        return String(format: "%d:%02d:%02d", hour, minute, second)
    }
}

// MARK: ISO8601DateFormatter
extension Date {
    init(dateString:String) {
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


extension Int {
//    func toDate() -> String {
//        let unixtimeInterval = self
//        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC +7:00")
//        dateFormatter.locale = NSLocale.current
//        
//        dateFormatter.dateFormat = "dd"
//        let day = dateFormatter.string(from: date)
//        dateFormatter.dateFormat = "MM"
//        let month = dateFormatter.string(from: date)
//        dateFormatter.dateFormat = "yyyy"
//        let year = dateFormatter.string(from: date)
//        
//        return "\(day) th\(month)"
//    }
    
    func toDatedmySlash() -> String {
        let unixtimeInterval = self
        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC +7:00")
        dateFormatter.locale = NSLocale.current
        
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        return "\(day)/\(month)/\(year)"
    }
}

extension Date {
    func getDateFor(days: Int) -> Date? {
         return Calendar.current.date(byAdding: .day, value: days, to: Date())
    }
    
    func removing(minutes: Int) -> Date? {
        return Calendar.current.date(byAdding: .minute, value: -(minutes), to: self)
    }
}
