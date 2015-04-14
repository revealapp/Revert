//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.scrollView.flashScrollIndicators()
  }
}
