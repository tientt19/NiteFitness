//
//  CellTableViewCategoryVideoFit.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//

import UIKit

class CellTableViewCategoryVideoFit: UITableViewCell {
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var img_VideoImage: UIImageView!
    @IBOutlet weak var lbl_VideoDuration: UILabel!
    @IBOutlet weak var lbl_VideoTitle: UILabel!
    @IBOutlet weak var progress_TimeLine: UIProgressView!
    
    var model: VideoModel? {
        didSet {
            self.img_VideoImage.setImageWith(imageUrl: self.model?.image ?? "")
            self.lbl_VideoDuration.text = self.model?.duration ?? ""
            self.lbl_VideoTitle.text = self.model?.name ?? ""
            
            if let lastSeen = self.model?.history {
                self.progress_TimeLine.isHidden = false
                self.progress_TimeLine.progress = Float(Int(lastSeen.lastSeenAt?.toTimeInterval() ?? 0)) / Float(Int(self.model?.duration?.toTimeInterval() ?? 0))

            } else {
                self.progress_TimeLine.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
