//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
  private var noOfItemsInRow: Int {
    switch UIApplication.sharedApplication().statusBarOrientation {
    case .Portrait, .PortraitUpsideDown, .Unknown:
      return 2
    case .LandscapeRight, .LandscapeLeft:
      // Scale is important here as size-classes cannot be used in projects compatible with iOS 7. Scale will be @3x
      // only on iPhone 6+ if and only if the device is not in scaled mode - which is exactly what we want.
      return UIScreen.mainScreen().scale > 2 ? 2 : 3
    }
  }
  
  private var totalItemsWidth: CGFloat {
    guard let collectionView = self.collectionView else {
      return 0
    }

    let horizontalSectionInsets = self.sectionInset.left + self.sectionInset.right
    return collectionView.bounds.width - horizontalSectionInsets
  }
  
  private var itemWidth: CGFloat {
    let separatorsWidth = (CGFloat(self.noOfItemsInRow - 1) * self.minimumInteritemSpacing)
    return floor((self.itemWidth - separatorsWidth) / CGFloat(self.noOfItemsInRow))
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return newBounds.size != self.collectionView?.bounds.size
  }

  override func prepareLayout() {
    super.prepareLayout()

    self.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
  }
}
