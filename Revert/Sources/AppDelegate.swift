//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    if let splitViewController = self.window?.rootViewController as? UISplitViewController {
      self.dynamicType.configureSplitViewController(splitViewController, delegate: self)
    }
    self.dynamicType.configureAppearance(self.window!)
    return true
  }
  
  private class func configureSplitViewController(splitViewController: UISplitViewController, delegate: UISplitViewControllerDelegate) {
    let navigationController = splitViewController.viewControllers.last as! UINavigationController
    if splitViewController.respondsToSelector("displayModeButtonItem") {
      navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    }
    splitViewController.delegate = delegate
  }
  
  private class func configureAppearance(window: UIWindow) {
    window.tintColor = UIColor.whiteColor()
  }
}

// MARK: - UISplitViewControllerDelegate

extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
    return secondaryViewController as? UINavigationController != nil;
  }
}

