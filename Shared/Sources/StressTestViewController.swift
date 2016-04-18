//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class StressTestViewController: RevertCollectionViewController { }

// MARK:- UICollectionViewDataSource
extension StressTestViewController {

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCellWithReuseIdentifier(Storyboards.Cell.Stress, forIndexPath: indexPath)
  }
}
