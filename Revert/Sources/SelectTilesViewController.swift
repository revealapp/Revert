//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class SelectTilesViewController: CollectionViewController {
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.collectionView!.flashScrollIndicators()
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    coordinator.animateAlongsideTransition({ (_) in
      self.collectionViewFlowLayout.invalidateLayout()
    }, completion: nil)
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

// MARK: UICollectionViewDelegateFlowLayout
extension SelectTilesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let itemWidth = floor((self.view.bounds.width - self.collectionViewFlowLayout.minimumInteritemSpacing) / 2.0)
    return CGSize(width: itemWidth, height: self.collectionViewFlowLayout.itemSize.height)
  }
}