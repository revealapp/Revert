//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class DualRowBasicCollectionViewFlowLayout: UICollectionViewFlowLayout {
  private static let noOfItemsInRow = 2

  private var availableWidth: CGFloat {
    guard let collectionView = self.collectionView else {
      return 0
    }

    return collectionView.bounds.width - self.sectionInset.left - self.sectionInset.right
  }

  private var computedItemSize: CGSize {
    let itemWidth = floor((self.availableWidth - self.minimumInteritemSpacing * (CGFloat(self.dynamicType.noOfItemsInRow) - 1)) / CGFloat(self.dynamicType.noOfItemsInRow))
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
