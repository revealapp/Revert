//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class StressTestViewController: UICollectionViewController {
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

extension StressTestViewController: UICollectionViewDataSource {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.noOfColumns * self.noOfRows
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.Stress, forIndexPath: indexPath) as! UICollectionViewCell
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension StressTestViewController: UICollectionViewDelegateFlowLayout {
  
  private var noOfColumns: Int {
    return Int(self.view.bounds.width / self.collectionViewFlowLayout.itemSize.width)
  }
  
  private var noOfRows: Int {
    return Int((self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length) / self.collectionViewFlowLayout.itemSize.height)
  }
  
  private var spacerWidth: CGFloat {
    return floor(self.view.bounds.width - CGFloat(self.noOfColumns) * self.collectionViewFlowLayout.itemSize.width) / CGFloat(self.noOfColumns - 1)
  }
}