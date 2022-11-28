//
//  CellCollHealthyCategoryHeader.swift
//  1SK
//
//  Created by TrungDN on 19/09/2022.
//

import UIKit

class CellCollHealthyCategoryHeader: UICollectionViewCell {
    @IBOutlet weak var contentViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_PostTitle: UILabel!
    @IBOutlet weak var img_Thumbnail: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    
    var filterType: HealthyLivingFilterType? {
        didSet {
            self.setFilterType()
        }
    }
    
    var model: PostHealthModel? {
        didSet {
            self.setupData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CellCollHealthyCategoryHeader {
    private func setFilterType() {
        guard let filterType = self.filterType else { return }
        self.lbl_Category.text = filterType.description
        switch filterType {
        case .all:
            self.contentViewLeadingConstraint.constant = 0
            self.contentViewTrailingConstraint.constant = 0
            
        default:
            self.contentViewLeadingConstraint.constant = 16
            self.contentViewTrailingConstraint.constant = 16
        }
        self.layoutIfNeeded()
    }
    
    private func setupData() {
        guard let model = self.model else { return }
        
        if let date = model.date?.toDate(.ymdThms) {
            self.lbl_Date.text = date.toString(.dmySlash)
            
        } else {
            let dayString = self.formatDay(from: model.postDate ?? "")
            self.lbl_Date.text = dayString
        }
        
        if let title = model.yoastHeadJson?.title {
            self.lbl_PostTitle.text = title
            
        } else {
            self.lbl_PostTitle.text = model.postTitle ?? ""
        }
        
        if let imageThumb = self.model?.yoastHeadJson?.ogImage?.first?.url {
            self.img_Thumbnail.setImage(with: imageThumb, completion: nil)
            
        } else {
            self.img_Thumbnail.setImage(with: model.postImages?.large ?? "", completion: nil)
        }
        
//        self.img_Thumbnail.setImage(with: model.yoastHeadJson?.ogImage?.first?.url ?? "", completion: nil)
//        self.lbl_PostTitle.text = model.yoastHeadJson?.title ?? model.postTitle ?? ""
//        self.lbl_Date.text = date?.toString(.dmySlash)
    }
    
    func formatDay(from day: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatterGet.date(from: day) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}
