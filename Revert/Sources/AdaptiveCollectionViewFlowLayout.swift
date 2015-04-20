//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
 
  private var noOfItemsInRow: Int {
    // TOOD: Determine # of horizontal items properly depending on device.
    return self.collectionView!.bounds.width > self.collectionView!.bounds.height ? 3 : 2
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  private var itemWidth: CGFloat {
    let widthWithSpacing = self.collectionView!.bounds.width / CGFloat(self.noOfItemsInRow)
    let widthTotalSpacing = (CGFloat(self.noOfItemsInRow - 1) * self.minimumInteritemSpacing)
    return floor(widthWithSpacing - widthTotalSpacing)
  }
  
  override var itemSize: CGSize {
    get {
      return CGSize(width: self.itemWidth, height: self.itemWidth)
    }
    set {
      super.itemSize = newValue
    }
  }
  
  override var minimumLineSpacing: CGFloat {
    get {
      let horizontalSectionInsets = self.sectionInset.left + self.sectionInset.right
      let horizontalItemSizes = self.collectionView!.bounds.width - (self.itemWidth * CGFloat(self.noOfItemsInRow))
      let noOfSeparators = CGFloat(self.noOfItemsInRow - 1)
      return floor((horizontalItemSizes - horizontalSectionInsets) / noOfSeparators)
    }
    set {
      super.minimumLineSpacing = newValue
    }
  }
}
