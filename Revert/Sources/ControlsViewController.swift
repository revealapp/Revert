//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ControlsViewController: RevertCollectionViewController {
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename, items = RevertItems(rawValue: resourceFilename) {
        let collection = CollectableCollection<Item>(items: items)
        self.dataSource = ControlsDataSource(collection: collection)
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
  private let keyboardHandler = KeyboardHandler()

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.resourceFilename != nil, "Resource file name should be set before `viewDidLoad`")

    // iOS 9 UICollectionViewControllers kinda handle the keyboard by themselves
    // The behaviour is not perfect, but there is no way to opt-out
    if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_3 {
      // Setup Keyboard Handler
      self.keyboardHandler.scrollView = self.collectionView
      self.keyboardHandler.viewController = self
    }

    // Setup Data Source
    self.collectionView!.dataSource = self.dataSource

    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "collectionViewTapped:")
    self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }

  func collectionViewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.collectionView?.endEditing(true)
  }
}
