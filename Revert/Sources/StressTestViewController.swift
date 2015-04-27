//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class StressTestViewController: UICollectionViewController {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCellWithReuseIdentifier(SB.Cell.Stress, forIndexPath: indexPath) as! UICollectionViewCell
  }
}
