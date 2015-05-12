//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class SplitViewControllerDelegate: NSObject, UISplitViewControllerDelegate {
  private var didShowDetailViewController = false
  
  func configureSplitViewController(splitViewController: UISplitViewController) {
    splitViewController.delegate = self
    if splitViewController.respondsToSelector("preferredDisplayMode") {
      splitViewController.preferredDisplayMode = .AllVisible
    }
  }

  func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
    self.didShowDetailViewController = true
    return false
  }
  
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
    return self.didShowDetailViewController == false
  }
  
  func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
    return false
  }
}