//
//  Encodable.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Foundation

extension Encodable {
    var jsonString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let `data` = try? encoder.encode(self) else {
            return nil
        }
        return String(data: data, encoding: .utf8) ?? nil
    }
    
    // vuongbachthu
    var jsonData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let `data` = try? encoder.encode(self) else {
            return nil
        }
        return data
    }
    
}
