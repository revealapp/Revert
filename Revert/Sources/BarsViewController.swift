//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class BarsViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
    self.dismissContainerView.addGestureRecognizer(dismissKeyboardGestureRecogniser)

    guard let firstTabBarItem = self.tabBar.items?.first else {
      fatalError("`UITabBar` should contain at least one item")
    }
    // Select TabBar's first item
    self.tabBar.selectedItem = firstTabBarItem
  }

  @objc func viewTapped(_ gestureRecogniser: UITapGestureRecognizer) {
    self.searchBar.resignFirstResponder()
  }

  // MARK: Private

  @IBOutlet private var searchBar: UISearchBar!
  @IBOutlet private var dismissContainerView: UIView!
  @IBOutlet private var tabBar: UITabBar!
}
