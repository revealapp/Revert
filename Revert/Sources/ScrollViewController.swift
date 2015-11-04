//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ScrollViewController: RevertViewController {
  @IBOutlet private weak var scrollView: UIScrollView!

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()
  }
}
