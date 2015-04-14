//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  private let collection = CollectableCollection<Control>(resourceFileName: "ControlItems")
  private let dataSource: CollectableCollectionViewDataSource
  private let keyboardHandler = KeyboardHandler()
  
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  required init(coder aDecoder: NSCoder) {
    self.dataSource = CollectableCollectionViewDataSource(collection: self.collection)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.keyboardHandler.scrollView = self.collectionView
    self.keyboardHandler.viewController = self
    
    self.collectionView!.dataSource = self.dataSource
    
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
    return section == self.collection.countOfGroups - 1
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
    return self.isLastSection(section) ? UIEdgeInsetsZero : self.collectionViewFlowLayout.sectionInset
  }
}