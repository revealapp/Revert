//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  private let collection = CollectableCollection<Control>(resourceFileName: "ControlItems")
  private let keyboardHandler = KeyboardHandler()
  
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.keyboardHandler.scrollView = self.collectionView
    self.keyboardHandler.viewController = self
    
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }
  
  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView!.endEditing(true)
  }
}

// MARK: UICollectionViewDataSource

extension ControlsViewController: UICollectionViewDataSource {
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return self.collection.countOfGroups
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.collection[section].countOfRows
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let item = self.collection.itemAtIndexPath(indexPath)
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(item.cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    return cell
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