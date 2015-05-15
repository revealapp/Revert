//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit


final class DualRowBasicCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  override func prepareLayout() {
    super.prepareLayout()
    
    let itemWidth = floor((self.collectionView!.bounds.width - self.minimumInteritemSpacing) / 2)
    self.itemSize = CGSize(width: itemWidth, height: self.itemSize.height)
  }
}

final class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
  private var noOfItemsInRow: Int {
    switch UIApplication.sharedApplication().statusBarOrientation {
    case .Portrait, .PortraitUpsideDown, .Unknown:
      return 2
    case .LandscapeRight, .LandscapeLeft:
      // Scale is important here as size-classes cannot be used project compatible with iOS 7. Scale will be @3x
      // only on iPhone 6+ if and only if the device is not in scaled mode - which is exactly what we want.
      return UIScreen.mainScreen().scale > 2 ? 2 : 3
    }
  }
  
  private var horizontalSectionInsets: CGFloat {
    return self.sectionInset.left + self.sectionInset.right
  }
  
  private var itemWidth: CGFloat {
    let itemsWidth = self.collectionView!.bounds.width - self.horizontalSectionInsets
    let separatorsWidth = (CGFloat(self.noOfItemsInRow - 1) * self.minimumInteritemSpacing)
    return floor((itemsWidth - separatorsWidth) / CGFloat(self.noOfItemsInRow))
  }
  
  override func prepareLayout() {
    super.prepareLayout()

    self.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
    let separatorsWidth = self.collectionView!.bounds.width - (self.itemWidth * CGFloat(self.noOfItemsInRow)) - self.horizontalSectionInsets
    self.minimumLineSpacing = floor(separatorsWidth / CGFloat(self.noOfItemsInRow - 1))
  }
}
