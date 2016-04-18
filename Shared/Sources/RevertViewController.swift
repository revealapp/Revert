//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

private extension UIViewController {
  func prepareForInfoSegue(segue: UIStoryboardSegue, item: HomeItem?) {
    guard let destinationNavigationController = segue.destinationViewController as? UINavigationController,
      destinationViewController = destinationNavigationController.topViewController as? SettableHomeItem else {
        fatalError("Destination view controller isn't a `UINavigationController` or its `topViewController` doesn't conform to `SettableHomeItem`")
    }

    guard let item = item else {
      fatalError("There should be an item present")
    }

    destinationViewController.item = item
  }
}

// MARK:- UIViewController
class RevertViewController: UIViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == Storyboards.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK:- UITableViewController
class RevertTableViewController: UITableViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }

    #if os(tvOS)
      self.dynamicType.adjustTVInsetsForTableView(self.tableView)
      self.automaticallyAdjustsScrollViewInsets = false
    #endif
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == Storyboards.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }

  // MARK: Private

  private static let overscanInsets = UIEdgeInsets(top: 60, left: 90, bottom: 60, right: 90)

  private static func adjustTVInsetsForTableView(tableView: UITableView) {
    tableView.layoutMargins = self.overscanInsets

    // We also have to account for overscan on the top and the bottom of the table view itself.
    // Content is initially offset so the table view doesn't jump when the inset update takes place.
    tableView.contentInset.top = self.overscanInsets.top
    tableView.contentInset.bottom = self.overscanInsets.bottom
    tableView.contentOffset.y = -self.overscanInsets.top
  }
}

// MARK:- UICollectionViewController
class RevertCollectionViewController: UICollectionViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == Storyboards.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK:- GLKViewController
class RevertGLKViewController: GLKViewController, SettableHomeItem {
  final var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")

    if self.item?.infoFilename == nil {
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == Storyboards.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}
