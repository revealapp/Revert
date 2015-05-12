//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class BarsViewController: UIViewController, SettableMasterItem {
  var item: MasterItem?
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var dismissContainerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.item != nil, "Item must be set before `viewDidLoad`")
    
    // Setup Dismiss Tap Gesture
    let dismissKeyboardGestureRecogniser = UITapGestureRecognizer(target: self, action: "viewTapped:")
    self.dismissContainerView.addGestureRecognizer(dismissKeyboardGestureRecogniser)
  }
  
  func viewTapped(gestureRecogniser: UITapGestureRecognizer) {
    self.searchBar.resignFirstResponder()
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}
