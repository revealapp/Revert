//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    guard let splitViewController = self.window?.rootViewController as? UISplitViewController else {
      fatalError("Root view controller should be a `UISplitViewController`")
    }
    self.splitViewControllerDelegate.configureSplitViewController(splitViewController)
    
    return true
  }
  
  // MARK: Private
  private var splitViewControllerDelegate = SplitViewControllerDelegate()
}

