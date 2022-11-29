//
//  CellTableViewResolutionVideo.swift
//  1SK
//
//  Created by Valerian on 04/07/2022.
//

import UIKit

class CellTableViewResolutionVideo: UITableViewCell {
    
    @IBOutlet weak var lbl_QualityVideo: UILabel!
    @IBOutlet weak var img_IsChoose: UIImageView!
    
    var label: String? {
        didSet {
            self.lbl_QualityVideo.text = label
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
            self.img_IsChoose.isHidden = false
        } else {
            self.backgroundColor = UIColor(hex: "232930")
            self.img_IsChoose.isHidden = true
        }
    }
    
}
