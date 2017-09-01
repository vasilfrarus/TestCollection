//
//  ChatCollectionViewLayout.swift
//  RemoteAssistant2
//
//  Created by Vasiliy Fedotov on 24/08/2017.
//  Copyright © 2017 1C Rarus. All rights reserved.
//

import UIKit

class ChatLayoutAttributes: UICollectionViewLayoutAttributes {
}

class ChatCollectionViewLayout: UICollectionViewLayout {

    private var cache = [ChatLayoutAttributes]()
    
    
    private var contentHeight: CGFloat!
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    
    override func prepare() {
        super.prepare()
        
        contentHeight = 0.0
        
        cache.removeAll()
        
        for idx in 0..<cells.count {
            
            let size = cells[idx]
            
            let cellWidth = size.width
            let cellHeight = size.height
            
            let indexPath = IndexPath(item: idx, section: 0)
            
            let attributes = ChatLayoutAttributes(forCellWith: indexPath)
            let xOrigin = contentWidth - cellWidth
            attributes.frame = CGRect(x: xOrigin, y: contentHeight, width: cellWidth, height: cellHeight)
            
            cache.append(attributes)
            
            contentHeight = contentHeight + cellHeight
        }
        
        
        let collectionViewHeight = collectionView!.bounds.height
        if (contentHeight < collectionViewHeight) {
            
            var yOrigin = collectionViewHeight - contentHeight
            
            for item in cache {
                item.frame.origin.y = yOrigin
                yOrigin += item.frame.height
            }
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            
            if rect.intersects(attributes.frame) {
                layoutAttributes.append(attributes)
            }
        }

        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let idx = indexPath.item
        
        return idx < cache.count ? cache[idx] : nil
    }
    
}
