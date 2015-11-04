//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionViewController: RevertCollectionViewController { }

// MARK: UICollectionViewDataSource
extension CollectionViewController {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.CollectionViewController, forIndexPath: indexPath)
    cell.contentView.backgroundColor = cell.selected ? UIColor.graySelectionColor() : UIColor.whitesmokeColor()
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension CollectionViewController {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.graySelectionColor()
  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.whitesmokeColor()
  }
}
