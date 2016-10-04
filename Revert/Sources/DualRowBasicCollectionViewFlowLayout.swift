//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class DualRowBasicCollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func prepare() {
    super.prepare()

    self.itemSize = self.computedItemSize
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return newBounds.size != self.collectionView?.bounds.size
  }

  // MARK: Private

  fileprivate static let noOfItemsInRow = 2

  fileprivate var availableWidth: CGFloat {
    guard let collectionView = self.collectionView else {
      return 0
    }

    return collectionView.bounds.width - self.sectionInset.left - self.sectionInset.right
  }

  fileprivate var computedItemSize: CGSize {
    let itemWidth = floor((self.availableWidth - self.minimumInteritemSpacing * (CGFloat(type(of: self).noOfItemsInRow) - 1)) / CGFloat(type(of: self).noOfItemsInRow))
    return CGSize(width: itemWidth, height: self.itemSize.height)
  }
}
