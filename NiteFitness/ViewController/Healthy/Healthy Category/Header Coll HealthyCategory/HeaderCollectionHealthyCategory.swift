//
//  HeaderCollectionHealthyCategory.swift
//  1SK
//
//  Created by TrungDN on 20/09/2022.
//

import UIKit

protocol CellCollHealthyCategoryHeaderDelegate {
    func openWebViewOnTap(url: URL)
}

class HeaderCollectionHealthyCategory: UICollectionReusableView {

    @IBOutlet weak var coll_HealthyLiving: UICollectionView!
    var delegate: CellCollHealthyCategoryHeaderDelegate!
        
    var model: [PostHealthModel]? {
        didSet {
            self.coll_HealthyLiving.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.coll_HealthyLiving.delegate = self
        self.coll_HealthyLiving.dataSource = self
        self.coll_HealthyLiving.registerNib(ofType: CellCollHealthyCategoryAll.self)
        self.coll_HealthyLiving.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

//MARK: -- UICollectionViewDelegate
extension HeaderCollectionHealthyCategory: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let link = self.model?[indexPath.item].link {
            guard let url = URL(string: link) else {
                return
            }
//            UIApplication.shared.open(url)
            self.delegate.openWebViewOnTap(url: url)
        }
    }
}

//MARK: -- UICollectionViewDataSource
extension HeaderCollectionHealthyCategory: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(ofType: CellCollHealthyCategoryAll.self, for: indexPath)
        cell.model = self.model?[indexPath.row]
        return cell
    }
}

//MARK: -- UICollectionViewDelegateFlowLayout
extension HeaderCollectionHealthyCategory: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 302, height: 188)
    }
}
