//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
 
  private var noOfItemsInRow: Int {
    switch UIApplication.sharedApplication().statusBarOrientation {
    case .Portrait, .PortraitUpsideDown:
      return 2
    default:
      return 3
    }
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }

  private var horizontalSectionInsets: CGFloat {
    return self.sectionInset.left + self.sectionInset.right
  }
  
  private var itemWidth: CGFloat {
    let itemsWidth = self.collectionView!.bounds.width - self.horizontalSectionInsets
    let separatorsWidth = (CGFloat(self.noOfItemsInRow - 1) * self.minimumInteritemSpacing)
    return floor((itemsWidth - separatorsWidth) / CGFloat(self.noOfItemsInRow))
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
      // Minimum Line Spacing must be equal to the real interItemSpacing.
      let separatorsWidth = self.collectionView!.bounds.width - (self.itemWidth * CGFloat(self.noOfItemsInRow)) - self.horizontalSectionInsets
      return floor(separatorsWidth / CGFloat(self.noOfItemsInRow - 1))
    }
    set {
      super.minimumLineSpacing = newValue
    }
  }
}
