//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private var splitViewControllerDelegate = SplitViewControllerDelegate()
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    if floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_0) || UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      guard let splitViewController = self.window?.rootViewController as? UISplitViewController else {
        fatalError("Root view controller should be a UISplitViewController on any device > iOS 7 or on iPads")
      }
      self.splitViewControllerDelegate.configureSplitViewController(splitViewController)
    }

    self.dynamicType.configureAppearance()
    return true
  }
  
  private class func configureAppearance() {
    UITabBar.appearance().tintColor = UIColor.revertTintColor()
    UINavigationBar.appearance().barTintColor = UIColor.revertTintColor()
  }
}
