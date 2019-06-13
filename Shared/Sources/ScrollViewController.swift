//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

class ScrollViewController: RevertViewController {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()
  }

  override var preferredFocusedView: UIView? {
    return self.scrollView
  }

  // MARK: Private

  @IBOutlet weak var scrollView: RevertFocusableScrollView!
}

#if os(tvOS)

  extension ScrollViewController {

    override func viewDidLoad() {
      super.viewDidLoad()

      self.scrollView.panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirect.rawValue as NSNumber]
    }
  }
#endif

final class RevertFocusableScrollView: UIScrollView {
  #if os(tvOS)
    override var canBecomeFocused: Bool {
      return true
    }
  #endif
}
