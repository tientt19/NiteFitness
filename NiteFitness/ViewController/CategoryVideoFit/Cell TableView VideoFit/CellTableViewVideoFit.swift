//
//  CellTableViewSavedVideos.swift
//  1SK
//
//  Created by Valerian on 24/06/2022.
//

import UIKit

protocol CellTableViewVideoFitDelegate: AnyObject {
    func onFavoriteAction(indexPath: IndexPath?)
}

class CellTableViewVideoFit: UITableViewCell {
    
    @IBOutlet weak var img_Image: UIImageView!
    @IBOutlet weak var view_Favorite: UIView!
    @IBOutlet weak var img_Favorite: UIImageView!
    @IBOutlet weak var btn_Favorite: UIButton!
    @IBOutlet weak var lbl_Time: PaddingLabel!
    
    @IBOutlet weak var progress_TimeLine: UIProgressView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Categry: UILabel!
    
    @IBOutlet weak var img_CoachAvatar: UIImageView!
    @IBOutlet weak var lbl_CoachName: UILabel!
    
    var delagate: CellTableViewVideoFitDelegate?
    var indexPath: IndexPath?
    
    var model: VideoModel? {
        didSet {
            self.lbl_Name.text = self.model?.name ?? ""
            self.lbl_Time.text = self.model?.durationDisplay ?? ""
            self.img_Image.setImageWith(imageUrl: self.model?.image ?? "")
            
            self.lbl_CoachName.text = self.model?.coach?.name ?? ""
            self.img_CoachAvatar.setImageWith(imageUrl: self.model?.coach?.avatar ?? "", placeHolder: R.image.default_avatar_2())
            
            self.lbl_Categry.text = self.model?.category?.name
            
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
        self.lbl_Time.edgeInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
    
    @IBAction func onFavoriteAction(_ sender: UIButton) {
        self.delagate?.onFavoriteAction(indexPath: self.indexPath)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
