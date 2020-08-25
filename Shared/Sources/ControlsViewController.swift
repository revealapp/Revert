//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ControlsViewController: RevertCollectionViewController {
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename, let items = RevertItems(rawValue: resourceFilename) {
        self.dataSource = ControlsDataSource(sections: items.data())
      } else if let resourceFilename = resourceFilename {
        fatalError("Unable to load file: \(resourceFilename)")
      } else {
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
    private let keyboardHandler = KeyboardHandler()
  #endif

  private var dataSource: ControlsDataSource?
}

extension ControlsViewController {

  @available(iOS 13.0, *)
  override func collectionView(_ collectionView: UICollectionView,
                               contextMenuConfigurationForItemAt indexPath: IndexPath,
                               point: CGPoint) -> UIContextMenuConfiguration? {
    guard dataSource?[indexPath].cellIdentifier == "ContextMenuCell" else {
      return nil
    }

    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
      let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { _ in }
      let deleteConfirmation = UIAction(title: "Delete",
                                        image: UIImage(systemName: "checkmark"),
                                        attributes: .destructive) { _ in }
      let delete = UIMenu(title: "Delete",
                          image: UIImage(systemName: "trash"),
                          options: .destructive,
                          children: [deleteCancel, deleteConfirmation])

      let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { _ in }
      let edit = UIMenu(title: "Edit...", options: .displayInline, children: [rename, delete])
      let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in }

      return UIMenu(title: "Context Menu Button", children: [share, edit])
    }
  }
}

#if os(iOS)

  extension ControlsViewController {

    private func setupKeyboardHandler() {
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
