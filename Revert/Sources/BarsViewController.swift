//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class BarsViewController: RevertViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var dismissContainerView: UIView!
  @IBOutlet weak var tabBar: UITabBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "viewTapped:")
    self.dismissContainerView.addGestureRecognizer(dismissKeyboardGestureRecogniser)
    
    // Select TabBar's first item
    self.tabBar.selectedItem = self.tabBar.items!.first! as? UITabBarItem
  }
  
  func viewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.searchBar.resignFirstResponder()
  }
}
