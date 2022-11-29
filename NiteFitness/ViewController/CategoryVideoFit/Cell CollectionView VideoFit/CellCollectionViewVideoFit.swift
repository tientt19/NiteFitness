//
//  CellCollectionViewVideoFit.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//

import UIKit

class CellCollectionViewVideoFit: UICollectionViewCell {
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Duration: UILabel!
    @IBOutlet weak var img_Image: UIImageView!
    
    var videoFeatured: VideoModel? {
        didSet {
            self.lbl_Name.text = self.videoFeatured?.name
            self.lbl_Duration.text = self.videoFeatured?.durationDisplay
            self.img_Image.setImageWith(imageUrl: self.videoFeatured?.image ?? "")
        }
    }
    
    var videoSuggest: VideoModel? {
        didSet {
            self.lbl_Name.text = self.videoSuggest?.name
            self.lbl_Duration.text = self.videoSuggest?.durationDisplay
            self.img_Image.setImageWith(imageUrl: self.videoSuggest?.image ?? "")
        }
    }
    
    var videoSegment: SegmentVideo? {
        didSet {
            self.lbl_Name.text = self.videoSegment?.title
            self.img_Image.setImageWith(imageUrl: self.videoSegment?.image ?? "")
            self.lbl_Duration.text = self.videoSegment?.startAt
        }
    }
    
    var videoRelated: VideoModel? {
        didSet {
            self.lbl_Name.text = self.videoRelated?.name
            self.lbl_Duration.text = self.videoRelated?.durationDisplay
            self.img_Image.setImageWith(imageUrl: self.videoRelated?.image ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
