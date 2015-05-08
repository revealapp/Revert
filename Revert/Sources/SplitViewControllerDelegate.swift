//
//  SplitViewControllerDelegate.swift
//  Revert
//
//  Created by Hugo Cuvillier on 8/05/2015.
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class SplitViewControllerDelegate: NSObject, UISplitViewControllerDelegate {

  private var didShowDetailViewController = false
  
  func configureSplitViewController(splitViewController: UISplitViewController) {
    splitViewController.delegate = self
    splitViewController.preferredDisplayMode = .AllVisible
  }

  func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
    self.didShowDetailViewController = true
    return false
  }
  
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
    return self.didShowDetailViewController == false
  }
}