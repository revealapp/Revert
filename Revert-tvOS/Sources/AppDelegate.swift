//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    guard let tabBarController = self.window?.rootViewController as? UITabBarController else {
      fatalError("Root view controller should be a `UITabBarController`")
    }
    
    return true
  }
  
  // MARK: Private
  private var splitViewControllerDelegate = SplitViewControllerDelegate()
}

