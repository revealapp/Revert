//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class ControlsViewController: RevertCollectionViewController {
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename {
        let collection = CollectableCollection<Item>(resourceFilename: resourceFilename)
        self.dataSource = ControlsDataSource(collection: collection, cellConfigurator: self.cellConfigurator)
        self.collection = collection
      } else {
        self.collection = nil
        self.dataSource = nil
      }
    }
  }
  
  private var collection: CollectableCollection<Item>?
  private var dataSource: ControlsDataSource?
  private let cellConfigurator = ControlCellConfigurator()
  private let keyboardHandler = KeyboardHandler()

  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.resourceFilename != nil, "Resource file name should be set before `viewDidLoad`")
    
    // Setup Keyboard Handler
    self.keyboardHandler.scrollView = self.collectionView
    self.keyboardHandler.viewController = self
    
    // Setup Data Source
    self.collectionView!.dataSource = self.dataSource
    
    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView!.endEditing(true)
  }
  
  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    self.collectionView!.reloadData()
  }
}
