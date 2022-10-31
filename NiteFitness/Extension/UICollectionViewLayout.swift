//
//  UICollectionViewLayout.swift
//  1SK
//
//  Created by Thaad on 20/05/2022.
// https://equaleyes.com/blog/2018/05/10/blog-flow-layout/

import Foundation
import UIKit

// MARK: UICollectionViewLayoutCustom
class UICollectionViewLayoutCustom: UICollectionViewFlowLayout {
    enum AlignLayoutCollectionView {
        case left
        case right
        case center
    }

    var alignment: AlignLayoutCollectionView?
    var spacing: CGFloat = 0

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [CollectionViewRow]()
        var currentRowY: CGFloat = -1

        for attribute in attributes {
            if currentRowY != attribute.frame.midY {
                currentRowY = attribute.frame.midY
                rows.append(CollectionViewRow(spacing: self.minimumLineSpacing))
            }
            rows.last?.add(attribute: attribute)
        }

        switch self.alignment {
        case .left:
            rows.forEach { $0.leftLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
            return rows.flatMap { $0.attributes }
            
        case .right:
            rows.forEach { $0.rightLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
            return rows.flatMap { $0.attributes }
            
        case .center:
            rows.forEach { $0.centerLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
            return rows.flatMap { $0.attributes }
            
        default:
            return nil
        }
    }
}

// MARK: CollectionViewRow
class CollectionViewRow {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        self.attributes.append(attribute)
    }

    var rowWidth: CGFloat {
        return self.attributes.reduce(0, { result, attribute -> CGFloat in
            return result + attribute.frame.width
        }) + CGFloat(self.attributes.count - 1) * self.spacing
    }

    func centerLayout(collectionViewWidth: CGFloat) {
        let padding: CGFloat = (collectionViewWidth - rowWidth) / 2
        var offset = padding
        for attribute in self.attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + self.spacing
        }
    }

    func leftLayout(collectionViewWidth: CGFloat) {
        let padding: CGFloat = 0.0
        var offset = padding
        for attribute in self.attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + self.spacing
        }
    }

    func rightLayout(collectionViewWidth: CGFloat) {
        let padding: CGFloat = collectionViewWidth - self.rowWidth
        var offset = padding
        for attribute in self.attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + self.spacing
        }
    }
}
