//
//  String.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
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

// MARK: Text String
extension String {
    /// Check if a string nil or empty
    /// - Parameters:
    ///   - aString: input string
    /// - Returns: Bool
    static func isNilOrEmpty(_ aString: String?) -> Bool {
        return !(aString != nil && !"\(aString ?? "")".isEmpty)
    }
    
    var isBackspace: Bool {
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
