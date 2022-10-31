//
//  CustomView.swift
//  myElcom
//
//  Created by Tiến Trần on 16/08/2022.
//

import Foundation
import UIKit

class CustomView: UIView {
    @IBOutlet var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.clipsToBounds = false
        containerView.constraintToAllSides(of: self)
        containerView.layer.masksToBounds = false
    }

    private func setupSelf() {
        Bundle.main.loadNibNamed(interfaceId, owner: self, options: nil)
        addSubview(containerView)
    }
}
