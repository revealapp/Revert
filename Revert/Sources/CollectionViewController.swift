//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
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

extension CollectionViewController: UICollectionViewDataSource {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.CollectionViewController, forIndexPath: indexPath) as! UICollectionViewCell
    
    cell.contentView.backgroundColor = cell.selected ? UIColor.awesgreenColor() : UIColor.whitesmokeColor()
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)!.contentView.backgroundColor = UIColor.awesgreenColor()
  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.cellForItemAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.whitesmokeColor()
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: floor((self.view.bounds.width - 1) / 2.0), height: self.collectionViewFlowLayout.itemSize.height)
  }
}