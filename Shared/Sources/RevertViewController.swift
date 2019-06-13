//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

private extension UIViewController {

  func prepareForInfoSegue(_ segue: UIStoryboardSegue, item: HomeItem?) {
    guard
      let destinationNavigationController = segue.destination as? UINavigationController,
      let destinationViewController = destinationNavigationController.topViewController as? SettableHomeItem
      else {
      fatalError("Destination view controller isn't a `UINavigationController` or its `topViewController` doesn't conform to `SettableHomeItem`")
    }

    guard let item = item else {
      fatalError("There should be an item present")
    }

    destinationViewController.item = item
  }
}

// MARK: - UIViewController
class RevertViewController: UIViewController, SettableHomeItem {
  final var item: HomeItem?

    @IBAction func breakBlueViewButtonTapped(_ sender: Any) {
        self.blueViewLeadingConstraint.constant = 0
    }
    @IBOutlet weak var blueViewLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if segue.identifier == SegueIdentifiers.info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: - UITableViewController
class RevertTableViewController: UITableViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }

    #if os(tvOS)
      self.tableView.adjustContentInsetsForTVOs()
      self.automaticallyAdjustsScrollViewInsets = false
    #endif
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if segue.identifier == SegueIdentifiers.info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: - UICollectionViewController
class RevertCollectionViewController: UICollectionViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if segue.identifier == SegueIdentifiers.info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: - GLKViewController
class RevertGLKViewController: GLKViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if segue.identifier == SegueIdentifiers.info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}
