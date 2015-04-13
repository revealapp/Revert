//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  private let collection = CollectableCollection<Control>(resourceFileName: "ControlItems")
  
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.registerNotifications()

    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }
  
  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView!.endEditing(true)
  }
}

// MARK: Notifications

extension ControlsViewController {
  
  private func registerNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShowHideNotification(notification: NSNotification) {
    let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
    let animationCurve = UIViewAnimationCurve(rawValue: notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int)!
    let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

    let keyboardFrameInView = self.collectionView!.superview!.convertRect(keyboardFrame, fromView: nil)
    let bottomInset = max(self.collectionView!.frame.maxY - keyboardFrameInView.minY, self.bottomLayoutGuide.length)
    let animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue) << 16)
    
    var contentInsets = self.collectionView!.contentInset
    var scrollIndicatorInsets = self.collectionView!.scrollIndicatorInsets
    
    contentInsets.bottom = bottomInset
    scrollIndicatorInsets.bottom = bottomInset

    UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationOptions, animations: {
      self.collectionView!.contentInset = contentInsets
      self.collectionView!.scrollIndicatorInsets = scrollIndicatorInsets
    }, completion: nil)
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