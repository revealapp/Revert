//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ControlsViewController: UICollectionViewController {
  @IBInspectable internal var resourceFilename: String? {
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
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    coordinator.animateAlongsideTransition({ (_) in
      self.collectionViewFlowLayout.invalidateLayout()
    }, completion: nil)
  }
}
