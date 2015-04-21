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
    
    self.dynamicType.configureAppearance()
    return true
  }
  
  private class func configureSplitViewController(splitViewController: UISplitViewController, delegate: UISplitViewControllerDelegate) {
    let navigationController = splitViewController.viewControllers.last as! UINavigationController
    if splitViewController.respondsToSelector("displayModeButtonItem") {
      navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    }
    splitViewController.delegate = delegate
  }
  
  private class func configureAppearance() {
    UITabBar.appearance().tintColor = UIColor.awesgreenColor()
  }
}

// MARK: - UISplitViewControllerDelegate

extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
    return secondaryViewController as? UINavigationController != nil;
  }
  
  func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
    if let tabBarController = splitViewController.viewControllers.first as? UITabBarController,
      selectedNavigationController = tabBarController.selectedViewController as? UINavigationController
      where splitViewController.collapsed {
        selectedNavigationController.showViewController(vc, sender: sender)
        return true
    }
    return false
  }
}
