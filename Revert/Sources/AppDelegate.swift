//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    if let splitViewController = self.window?.rootViewController as? UISplitViewController {
      self.dynamicType.configureSplitViewController(splitViewController, delegate: self)
    }
    
    self.dynamicType.configureAppearance()
    return true
  }
  
  private class func configureSplitViewController(splitViewController: UISplitViewController, delegate: UISplitViewControllerDelegate) {
    splitViewController.preferredDisplayMode = UIDevice.currentDevice().userInterfaceIdiom == .Pad ? .AllVisible : .PrimaryHidden
    splitViewController.preferredDisplayMode = .AllVisible
    splitViewController.delegate = delegate
  }
  
  private class func configureAppearance() {
    UITabBar.appearance().tintColor = UIColor.revertTintColor()
    UINavigationBar.appearance().barTintColor = UIColor.revertBlueColor()
  }
}

extension AppDelegate: UISplitViewControllerDelegate {
}
