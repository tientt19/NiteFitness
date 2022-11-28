//
//  CellCollHealthyCategoryAll.swift
//  1SK
//
//  Created by Tiến Trần on 06/10/2022.
//

import UIKit
import TagListView

class CellCollHealthyCategoryAll: UICollectionViewCell {
    @IBOutlet weak var lbl_PostTitle: UILabel!
    @IBOutlet weak var img_Thumbnail: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var view_TagListView: TagListView!
    
    var model: PostHealthModel? {
        didSet {
            self.setupData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension CellCollHealthyCategoryAll {
    private func setupData() {
        guard let model = self.model else { return }
        self.view_TagListView.removeAllTags()
        
        self.view_TagListView.textFont = R.font.robotoMedium(size: 16)!
        self.view_TagListView.alignment = .leading
        
        if let postCategory = self.model?.postCategories {
            self.view_TagListView.addTag(postCategory.first?.name ?? "")
        }
        
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
