//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class ScrollViewController: UIViewController, SettableMasterItem {
  var item: MasterItem?
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.scrollView.flashScrollIndicators()
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}
