//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class DualRowBasicCollectionViewFlowLayout: UICollectionViewFlowLayout {
  private let noOfItemsInRow = 2
  
  private var computedItemSize: CGSize {
    let itemWidth = floor((self.collectionView!.bounds.width - self.minimumInteritemSpacing - self.sectionInset.left - self.sectionInset.right) / CGFloat(self.noOfItemsInRow))
    return CGSize(width: itemWidth, height: self.itemSize.height)
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return newBounds.size != self.collectionView?.bounds.size
  }
  
  override func prepareLayout() {
    super.prepareLayout()
    
    self.itemSize = self.computedItemSize
  }
}