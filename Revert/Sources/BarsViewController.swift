//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class BarsViewController: RevertViewController {
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var dismissContainerView: UIView!
  @IBOutlet private weak var tabBar: UITabBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "viewTapped:")
    self.dismissContainerView.addGestureRecognizer(dismissKeyboardGestureRecogniser)

    guard let firstTabBarItem = self.tabBar.items?.first else {
      fatalError("`UITabBar` should contain at least one item")
    }
    // Select TabBar's first item
    self.tabBar.selectedItem = firstTabBarItem
  }
  
  func viewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.searchBar.resignFirstResponder()
  }
}
