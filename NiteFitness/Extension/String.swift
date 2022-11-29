//
//  String+Extension.swift
//  1SK
//
//  Created by tuyenvx on 15/01/2021.
//

import Foundation
import UIKit

extension String {
    
    var fullHTMLString: String? {
        return  """
            <!DOCTYPE html>
            <html>
            <style>
                img {
                    display: block;
                    width: 100%;
                    height: auto;
                };
                
            </style>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, viewport-fit=corver"/>
            </head>
            <body>
            \(self)
            </body>
            </html>
        """
    }
    
    var asHtmlStoreProductInfo: String? {
        guard let filePath = Bundle.main.path(forResource: "StoreProductInfo", ofType: "html") else {
            return nil
        }
        
        do {
            let baseHTML = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            let desString = baseHTML.replacingOccurrences(of: "Content...", with: self)
            return desString
            
        } catch {
            return nil
        }
    }

    func toTimeInterval() -> TimeInterval? {
        guard !self.isEmpty else {
            return nil
        }
        var interval: Double = 0

        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        return interval
    }

    func toDate(_ format: Date.Format) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format.rawValue
        dateFormater.locale = Locale(identifier: "vi")
        return dateFormater.date(from: self)
    }
    
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "HH:mm  dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func convertDateFormaterString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "dd thMM"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func convertDateFormater(date: String, formate: Date.Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = formate.rawValue
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func convertTimeFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC+07") as TimeZone?
        dateFormatter.locale = Locale(identifier: "vi")

        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    func isNumber() -> Bool {
        let numberRegex = "^[0-9]+(?:[.,][0-9]+)*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return predicate.evaluate(with: self)
    }
    
    func isVietnameseName() -> Bool {
        let characterset = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ ")
        return self.rangeOfCharacter(from: characterset.inverted) == nil
    }

    var doubleValue: Double? {
        var string = self
        if let range = range(of: ",") {
            string = self.replacingCharacters(in: range, with: ".")
        }
        let numberFormater = NumberFormatter()
        numberFormater.minimumFractionDigits = 0
        numberFormater.decimalSeparator = "."
        return numberFormater.number(from: self) as? Double
    }
}

extension Optional where Wrapped == String {
    func toURLPath() -> String {
        if let id = self {
            return "/\(id)"
        } else {
            return ""
        }
    }
}

// by vuongbachthu
// MARK: Text String
extension String {
    var isBackSpace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    var toUrl: String {
        return self.replaceCharacter(target: " ", withString: "+")
    }
    
    var toNonAlphaNumeric: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
    
    var isNumberInt: Bool {
        return Int(self) != nil
    }
    
    var isNumberDouble: Bool {
        return Double(self) != nil
    }
    
//    var isNumber: Bool {
//        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
//    }
    
    func replaceCharacter(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    
}

// MARK: Format Phone Number
extension String {
    func formatPhoneNumber(pattern: String, replacmentCharacter: Character) -> String? {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for (index, _) in pattern.enumerated() {
            guard index < pureNumber.count else { return pureNumber}
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

// MARK: Date - Time
extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}

// MARK: HTLM - Attributed
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

// MARK: Dictionary
extension String {
    func toDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}

// MARK: SubString
extension String {
    // Usage
    // let text = "Hello world"
    // text[0] // H
    // text[...3] // "Hell"
    // text[6..<text.count] // world
    // text[NSRange(location: 6, length: 3)] // wor
    
    subscript(value: Int) -> Character {
      self[index(at: value)]
    }
    
    subscript(value: NSRange) -> Substring {
      self[value.lowerBound..<value.upperBound]
    }
    
    func index(at offset: Int) -> String.Index {
      index(startIndex, offsetBy: offset)
    }
    
    subscript(value: CountableClosedRange<Int>) -> Substring {
      self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }

    subscript(value: CountableRange<Int>) -> Substring {
      self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring {
      self[..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring {
      self[...index(at: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring {
      self[index(at: value.lowerBound)...]
    }
}

// MARK: Attributed String
extension NSMutableAttributedString {
    var fontSize: CGFloat { return 14 }
    var boldFont: UIFont { return UIFont(name: "Roboto-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont: UIFont { return UIFont(name: "Roboto-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value: String) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func normal(_ value: String) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    /* Other styling methods */
    func orangeHighlight(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func blackHighlight(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func underlined(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}

// MARK: Decode - Encoded UTF8
extension String {
    func utf8DecodedString() -> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString() -> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}

// MARK: Valiadate Email
extension String {
    /// Check if a string nil or empty
    /// - Parameters:
    ///   - aString: input string
    /// - Returns: Bool
    static func isNilOrEmpty(_ aString: String?) -> Bool {
        return !(aString != nil && !"\(aString ?? "")".isEmpty)
    }
    
    func isValidEmail() -> Bool? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var containsDigits: Bool {
        return(self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil)
    }
    
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    /// Height for  text with fixed width
    /// - Parameters:
    ///   - width: fixed width
    ///   - font: font
    /// - Returns: CGFloat
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Width for  text with fixed height
    /// - Parameters:
    ///   - height: fixed height
    ///   - font: font
    /// - Returns: CGFloat
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
