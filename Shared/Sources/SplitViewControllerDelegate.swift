//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class SplitViewControllerDelegate: NSObject, UISplitViewControllerDelegate {
  func configureSplitViewController(_ splitViewController: UISplitViewController) {
    splitViewController.delegate = self
    splitViewController.preferredDisplayMode = .allVisible
  }

  func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
    self.didShowDetailViewController = true
    return false
  }

  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return self.didShowDetailViewController == false
  }

  // MARK: Private
  fileprivate var didShowDetailViewController = false
}
