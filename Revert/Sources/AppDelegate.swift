//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.dynamicType.configureSplitViewController(self.window!.rootViewController as! UISplitViewController, delegate: self)
    self.dynamicType.configureAppearance(self.window!)
    return true
  }
  
  private class func configureSplitViewController(splitViewController: UISplitViewController, delegate: UISplitViewControllerDelegate) {
    let navigationController = splitViewController.viewControllers.last as! UINavigationController
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    splitViewController.delegate = delegate
  }
  
  private class func configureAppearance(window: UIWindow) {
    window.tintColor = UIColor.alizarinColor()
  }
}

// MARK: - UISplitViewControllerDelegate

extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
    return secondaryViewController as? UINavigationController != nil;
  }
}

