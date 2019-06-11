//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let splitViewController = self.window?.rootViewController as? UISplitViewController {
      self.splitViewControllerDelegate.configureSplitViewController(splitViewController)
    }

    type(of: self).configureAppearance()

    return true
  }

  @available(iOS 13.0, *)
  func sceneWillEnterForeground(_ scene: UIScene) {
    if let splitViewController = self.window?.rootViewController as? UISplitViewController {
      self.splitViewControllerDelegate.configureSplitViewController(splitViewController)
    }

    type(of: self).configureAppearance()
  }

  // MARK: Private

  // swiftlint:disable weak_delegate
  private var splitViewControllerDelegate = SplitViewControllerDelegate()
  // swiftlint:enable weak_delegate

  private static func configureAppearance() {
    UITabBar.appearance().tintColor = .revertTint
    UINavigationBar.appearance().barTintColor = .revertTint
  }
}

@available(iOS 13.0, *)
extension AppDelegate: UIWindowSceneDelegate {

}
