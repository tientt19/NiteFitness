//
//  VideoDetailModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 29/11/2022.
//

import Foundation

class VideoDetailModel: Codable {
    var id: Int?
    var attribute: AttributeModel?
    var value: AtrributeValueModel?
    
    func getTitle() -> String {
        let atributeName = attribute?.name ?? ""
        let valueName = value?.name ?? ""
        return "\(atributeName): \(valueName)"
    }

    func getAtrributedTitle() -> NSMutableAttributedString {
        let atributeName = NSAttributedString(string: "\(attribute?.name ?? ""): ",
                                              attributes: [NSAttributedString.Key.foregroundColor: R.color.subTitle()!])
        let valueName = NSAttributedString(string: value?.name ?? "",
                                           attributes: [NSAttributedString.Key.foregroundColor: R.color.darkText()!])
        let title = NSMutableAttributedString(attributedString: atributeName)
        title.append(valueName)
        return title
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case attribute
        case value
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.attribute = try? values.decode(AttributeModel.self, forKey: .attribute)
        self.value = try? values.decode(AtrributeValueModel.self, forKey: .value)
    }
}
