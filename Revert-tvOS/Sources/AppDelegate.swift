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

    // UISearchController can't be added through Storyboards as of tvOS 9
    tabBarController.viewControllers?.append(self.dynamicType.packagedSearchController())
    
    return true
  }

  // MARK: Private
  private static func packagedSearchController() -> UIViewController {
    // Load the view controller that will act as data source from its storyboard, so we don't have to do layout programmatically.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let searchViewController = storyboard.instantiateViewControllerWithIdentifier(Storyboards.VC.SearchController) as? SearchViewController else {
      fatalError("Unable to instantiate `SearchViewController` from the main storyboard file.")
    }

    let searchController = UISearchController(searchResultsController: searchViewController)
    searchController.searchResultsUpdater = searchViewController
    searchController.searchBar.placeholder = NSLocalizedString("Enter name or city", comment: "Search prompt")

    // UISearchController needs to be inside a container view controller when presented as part of the navigation of the app.
    let searchContainer = UISearchContainerViewController(searchController: searchController)
    searchContainer.title = NSLocalizedString("Search", comment: "Search controller container title")

    let searchNavigationController = UINavigationController(rootViewController: searchContainer)
    return searchNavigationController
  }
}

