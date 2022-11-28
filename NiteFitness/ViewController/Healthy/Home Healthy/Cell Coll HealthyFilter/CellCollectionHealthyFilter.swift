//
//  CellCollectionHealthyFilter.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//

import UIKit

class CellCollectionHealthyFilter: UICollectionViewCell {
    
    @IBOutlet weak var view_Background: UIView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.setSelected(isSelected: self.isSelected)
        }
    }
    
    var title: String? {
        didSet {
            self.setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: Helpers
extension CellCollectionHealthyFilter {
    private func setSelected(isSelected: Bool) {
        self.view_Background.backgroundColor = isSelected ? R.color.mainColor() : UIColor(hex: "F1F1F1")
        self.lbl_Title.textColor = isSelected ? UIColor.white : R.color.title()
        self.lbl_Title.font = isSelected ? R.font.robotoMedium(size: 14)! : R.font.robotoRegular(size: 14)!
    }
    
    private func setData() {
        guard let model = self.title else { return }
        self.lbl_Title.text = model
    }
}
