//
//  CellTableViewSegmentTime.swift
//  1SK
//
//  Created by Valerian on 04/07/2022.
//

import UIKit

class CellTableViewSegmentTime: UITableViewCell {
    
    @IBOutlet weak var img_SegmentLive: UIImageView!
    @IBOutlet weak var lbl_SegmentName: UILabel!
    @IBOutlet weak var lbl_SegmentDuration: UILabel!
    
    var segmentVideo: SegmentVideo? {
        didSet {
            self.lbl_SegmentName.text = segmentVideo?.title ?? ""
            self.lbl_SegmentDuration.text = segmentVideo?.startAt ?? ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = UIColor(hex: "121212")
            self.img_SegmentLive.isHidden = false
            self.lbl_SegmentName.textColor = R.color.mainColor()
            self.lbl_SegmentDuration.textColor = R.color.mainColor()
        } else {
            self.backgroundColor = UIColor(hex: "232930")
            self.img_SegmentLive.isHidden = true
            self.lbl_SegmentName.textColor = .white
            self.lbl_SegmentDuration.textColor = .white
        }
    }
    
}
