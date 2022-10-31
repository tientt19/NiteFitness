//
//  Utils.swift
//  1SK
//
//  Created by vuongbachthu on 7/6/21.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    func getTimeSystemWidthStamp() -> Double {
        let timestamp = NSDate().timeIntervalSince1970
        let timeNow = TimeInterval(timestamp) as Double
        return timeNow
    }
    
    func getDateSystemByString(timeFormat: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi")
        formatter.dateFormat = timeFormat
        
        return formatter.string(from: date)
    }
    
    func getTimeStringByTimeStamp(timeStamp: Double, timeFomat: String) -> String {
        let _interval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: _interval)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi") //Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = timeFomat //"h:mm a"
        return formatter.string(from: date)
    }
    
    func getTimeStringByDate(date: Date, timeFomat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFomat //"h:mm a"
        return formatter.string(from: date)
    }
    
    func getTimeDateByTimeStamp(timeStamp: Double) -> Date {
        let _interval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: _interval)
        return date
    }
    
    func getFormatDateTime(dateTime: Date, timeFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi")
        formatter.dateFormat = timeFormat
        
        return formatter.string(from: dateTime)
    }
    
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        //let (h,m,s) = secondsToHoursMinutesSeconds(27005)
    }
    
    func getDateByString(dateStr: String?) -> Date? {
        if dateStr == nil {
            return nil
        }
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let dateComponentArray = dateStr!.components(separatedBy: "/")

        if dateComponentArray.count == 3 {
            var components = DateComponents()
            components.year = Int(dateComponentArray[2])
            components.month = Int(dateComponentArray[1])
            components.day = Int(dateComponentArray[0])
            components.timeZone = TimeZone(abbreviation: "GMT+0:00")
            guard let date = calendar.date(from: components) else {
                return nil
            }
            return date
            
        } else {
            return nil
        }
    }
}
