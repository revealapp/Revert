//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class ControlsViewController: RevertCollectionViewController {
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename, items = RevertItems(rawValue: resourceFilename) {
        let collection = CollectableCollection<Item>(items: items)
        self.dataSource = ControlsDataSource(collection: collection, cellConfigurator: self.cellConfigurator)
        self.collection = collection
      } else if let resourceFilename = resourceFilename {
        fatalError("Unable to load file: \(resourceFilename)")
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

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.resourceFilename != nil, "Resource file name should be set before `viewDidLoad`")

    // iOS 9 UICollectionViewControllers kinda handle the keyboard by themselves
    // The behaviour is not perfect, but there is no way to opt-out
    if #available(iOS 9.0, *) {
    } else {
        // Setup Keyboard Handler
        self.keyboardHandler.scrollView = self.collectionView
        self.keyboardHandler.viewController = self
    }
    
    // Setup Data Source
    self.collectionView!.dataSource = self.dataSource
    
    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
    
    // Setup dynamic type notifications.
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView?.endEditing(true)
  }
  
  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    // Reload tableview to update the cell font sizes.
    self.collectionView?.reloadData()
  }
}
