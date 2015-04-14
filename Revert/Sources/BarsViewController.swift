//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class BarsViewController: UICollectionViewController {
  private let collection = CollectableCollection<Item>(resourceFileName: "BarItems")
  private let dataSource: CollectableCollectionViewDataSource
  private let keyboardHandler = KeyboardHandler()
  
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  required init(coder aDecoder: NSCoder) {
    self.dataSource = CollectableCollectionViewDataSource(collection: self.collection)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup KeyboardHandler
    self.keyboardHandler.scrollView = self.collectionView
    self.keyboardHandler.viewController = self

    // Setup DataSource
    self.collectionView!.dataSource = self.dataSource

    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }
  
  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView!.endEditing(true)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension BarsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: self.collectionViewFlowLayout.itemSize.height)
  }
}
