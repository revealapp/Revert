//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class SelectTilesViewController: CollectionViewController {
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
}

// MARK: UICollectionViewDataSource
extension SelectTilesViewController: UICollectionViewDataSource {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.CollectionViewController, forIndexPath: indexPath) as! UICollectionViewCell
    
    cell.contentView.backgroundColor = cell.selected ? UIColor.revertTintColor() : UIColor.whitesmokeColor()
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension SelectTilesViewController: UICollectionViewDelegate {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)!.contentView.backgroundColor = UIColor.graySelectionColor()
  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.whitesmokeColor()
  }
}
