//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class StressTestViewController: RevertCollectionViewController { }

// MARK: UICollectionViewDataSource
extension StressTestViewController: UICollectionViewDataSource {
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.Stress, forIndexPath: indexPath) as? UICollectionViewCell {
      return cell
    } else {
      fatalError("Expecting to dequeue a UICollectionViewCell from the UICollectionView")
    }
  }
}
