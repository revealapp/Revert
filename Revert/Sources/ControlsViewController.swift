//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  internal var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename {
        let collection = CollectableCollection<Item>(resourceFilename: resourceFilename)
        self.dataSource = CollectableCollectionViewDataSource(collection: collection)
        self.collection = collection
      } else {
        self.collection = nil
        self.dataSource = nil
      }
    }
  }
  
  private var collection: CollectableCollection<Item>?
  private var dataSource: CollectableCollectionViewDataSource?
  private let keyboardHandler = KeyboardHandler()

  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.resourceFilename != nil, "Resource file name should be set before viewDidLoad:")

    // Setup Keyboard Handler
    self.keyboardHandler.scrollView = self.collectionView
    self.keyboardHandler.viewController = self
    
    // Setup Data Source
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

extension ControlsViewController: UICollectionViewDelegateFlowLayout {
  private func isLastSection(section: Int) -> Bool {
    return section == self.collection!.countOfGroups - 1
  }
  
  private var noOfItemsInRow: Int {
    // TOOD: Determine # of horizontal items properly depending on device.
    return self.view.bounds.width > self.view.bounds.height ? 3 : 2
  }
  
  private var itemWidth: CGFloat {
    return floor(self.collectionView!.bounds.width / CGFloat(self.noOfItemsInRow) - (CGFloat(self.noOfItemsInRow) - 1.0))
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: self.itemWidth, height: self.itemWidth)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0.0, left: 1.0, bottom: self.isLastSection(section) ? 0.0 : 35.0, right: 1.0)
  }
}