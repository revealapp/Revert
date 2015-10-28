//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AdaptiveCollectionViewFlowLayout: UICollectionViewFlowLayout {
  private let minColumnsForLayout = 2
  private let maxColumnsForLayout = 3
  private let minCellWidth: CGFloat = 150

  private var cellWidthForCollectionView: CGFloat {
    let totalPadding = CGFloat(maxColumnsForLayout - 1) * self.minimumInteritemSpacing + self.sectionInset.left + self.sectionInset.right
    let collectionViewWidth = CGRectGetWidth(self.collectionView!.bounds)
    return (collectionViewWidth - totalPadding) / CGFloat(maxColumnsForLayout)
  }

  private var noOfItemsInRow: Int {
    if cellWidthForCollectionView < minCellWidth {
      return minColumnsForLayout
    }
    else {
      return maxColumnsForLayout
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
    return floor((self.totalItemsWidth - separatorsWidth) / CGFloat(self.noOfItemsInRow))
  }

  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return newBounds.size != self.collectionView?.bounds.size
  }

  override func prepareLayout() {
    super.prepareLayout()

    self.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
  }
}
