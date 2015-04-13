//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  private let collection = CollectableCollection<Control>(resourceFileName: "ControlItems")
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
  }
}

// MARK: Notifications

extension ControlsViewController {
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

// MARK: UICollectionViewDelegate

extension ControlsViewController: UICollectionViewDelegate {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.endEditing(true)
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
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let size = floor((self.view.bounds.width - 1) / 2.0)
    return CGSize(width:size , height: size)
  }
}