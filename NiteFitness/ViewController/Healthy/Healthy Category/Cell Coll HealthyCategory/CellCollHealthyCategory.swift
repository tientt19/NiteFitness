//
//  CellCollHealthyCategory.swift
//  1SK
//
//  Created by TrungDN on 19/09/2022.
//

import UIKit

class CellCollHealthyCategory: UICollectionViewCell {
    
    @IBOutlet weak var lbl_PostTitle: UILabel!
    @IBOutlet weak var img_Thumbnail: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    
    var model: PostHealthModel? {
        didSet {
            self.setupData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupData() {
        guard let model = self.model else { return }
        let date = model.date?.toDate(.ymdThms)
        self.img_Thumbnail.setImage(with: model.yoastHeadJson?.ogImage?.first?.url ?? "", completion: nil)
        self.lbl_PostTitle.text = model.yoastHeadJson?.title ?? ""
        self.lbl_Date.text = date?.toString(.dmySlash)
    }
}
