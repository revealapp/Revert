//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ControlsViewController: RevertCollectionViewController {
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename, let items = RevertItems(rawValue: resourceFilename) {
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

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.resourceFilename != nil, "Resource file name should be set before `viewDidLoad`")

    // Setup Data Source
    self.collectionView!.dataSource = self.dataSource

    #if os(iOS)
      self.setupKeyboardHandler()
    #endif
  }

  // MARK: Private

  #if os(iOS)
    fileprivate let keyboardHandler = KeyboardHandler()
  #endif

  fileprivate var collection: CollectableCollection<Item>?
  private var dataSource: ControlsDataSource?
}

#if os(iOS)

  extension ControlsViewController {

    fileprivate func setupKeyboardHandler() {
      // iOS 9 UICollectionViewControllers kinda handle the keyboard by themselves
      // The behaviour is not perfect, but there is no way to opt-out
      if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_4 {
        // Setup Keyboard Handler
        self.keyboardHandler.scrollView = self.collectionView
        self.keyboardHandler.viewController = self
      }

      // Setup Dismiss Tap Gesture
      let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.collectionViewTapped(_:)))
      self.collectionView!.addGestureRecognizer(dismissKeyboardGestureRecogniser)
    }

    @objc func collectionViewTapped(_ gestureRecogniser: UITapGestureRecognizer) {
      self.collectionView?.endEditing(true)
    }
  }
#endif
