//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    guard let splitViewController = self.window?.rootViewController as? UISplitViewController else {
      fatalError("Root view controller should always be a `UISplitViewController`")
    }
    self.splitViewControllerDelegate.configureSplitViewController(splitViewController)

    self.dynamicType.configureAppearance()

    return true
  }

  // MARK: Private

  private var splitViewControllerDelegate = SplitViewControllerDelegate()

  private static func configureAppearance() {
    UITabBar.appearance().tintColor = UIColor.revertTintColor()
    UINavigationBar.appearance().barTintColor = UIColor.revertTintColor()
  }
}
