//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

internal final class StressTestViewController: UICollectionViewController, SettableMasterItem {
  var item: MasterItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}

// MARK: UICollectionViewDataSource
extension StressTestViewController: UICollectionViewDataSource {
  
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
