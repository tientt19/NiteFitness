//
//  UIImageView.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageWith(imageUrl: String, placeHolder: UIImage? = nil) {
        let url = URL(string: imageUrl)
//        print("./Image: \(imageUrl)")
        let processor = DownsamplingImageProcessor(size: bounds.size)
        kf.setImage(with: url, placeholder: placeHolder,
                    options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale)
        ])
    }

    func setImage(with imageURL: String, completion: ((UIImage) -> Void)?) {
        guard let url = URL(string: imageURL) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.image = result.image
                    completion?(result.image)
                }
            case .failure:
                break
            }
        }
    }
}

