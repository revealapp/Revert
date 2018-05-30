//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ScrollViewController: RevertViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()
  }

  override var preferredFocusedView: UIView? {
    return self.scrollView
  }

  // MARK: Private

  @IBOutlet fileprivate var scrollView: RevertFocusableScrollView!
}

#if os(tvOS)

  extension ScrollViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      self.scrollView.panGestureRecognizer.allowedTouchTypes = [UITouchType.indirect.rawValue as NSNumber]
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
