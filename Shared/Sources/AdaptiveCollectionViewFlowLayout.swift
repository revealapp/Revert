//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()

    let itemWidth = self.itemWidth
    self.itemSize = CGSize(width: itemWidth, height: itemWidth)
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return newBounds.size != self.collectionView?.bounds.size
  }

  // MARK: Private

  fileprivate static let minimumColumnsForLayout = 2
  fileprivate static let maximumColumnsForLayout = 3
  fileprivate static let minimumCellWidth: CGFloat = 150

  fileprivate var itemWidth: CGFloat {
    return self.itemWidthForNumberOfColumns(self.numberOfColumns)
  }

  fileprivate var numberOfColumns: Int {
    if self.itemWidthForNumberOfColumns(type(of: self).maximumColumnsForLayout) >= type(of: self).minimumCellWidth {
      return type(of: self).maximumColumnsForLayout
    } else {
      return type(of: self).minimumColumnsForLayout
    }
  }

  fileprivate func itemWidthForNumberOfColumns(_ numberOfColumns: Int) -> CGFloat {
    guard let collectionView = self.collectionView else {
      return 0
    }

    let totalPadding = CGFloat(numberOfColumns - 1) * self.minimumInteritemSpacing + self.sectionInset.left + self.sectionInset.right
    return (collectionView.bounds.width - totalPadding) / CGFloat(numberOfColumns)
  }
}
