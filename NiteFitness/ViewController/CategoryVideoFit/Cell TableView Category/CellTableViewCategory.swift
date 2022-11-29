//
//  CellTableViewCategory.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//

import UIKit

class CellTableViewCategory: UITableViewCell {
    
    @IBOutlet weak var view_Container: UIView!
    @IBOutlet weak var img_CategoryExercise: UIImageView!
    @IBOutlet weak var lbl_CategoryExercise: UILabel!
    
    var model: Children? {
        didSet {
            self.img_CategoryExercise.setImageWith(imageUrl: model?.image ?? "")
            if model?.name == "Body Rhythm" {
                self.lbl_CategoryExercise.text = "Body\nRhythm"
            } else {
                self.lbl_CategoryExercise.text = model?.name ?? ""
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.view_Container.backgroundColor = .white
            self.lbl_CategoryExercise.textColor = .black
            
        } else {
            self.view_Container.backgroundColor = UIColor(red: 0.946, green: 0.942, blue: 0.942, alpha: 1)
            self.lbl_CategoryExercise.textColor = UIColor(red: 0.451, green: 0.463, blue: 0.471, alpha: 1)
        }
    }
    
}
