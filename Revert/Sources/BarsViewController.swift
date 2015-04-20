//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class BarsViewController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tabBar: UITabBar!
  @IBOutlet weak var dismissContainerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Select TabBar's first item
    self.tabBar.selectedItem = self.tabBar.items!.first! as? UITabBarItem

    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "viewTapped:")
    self.dismissContainerView.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }
  
  internal func viewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.searchBar.resignFirstResponder()
  }
}
