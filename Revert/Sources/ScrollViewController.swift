//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ScrollViewController: RevertViewController {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()
  }

  override var preferredFocusedView: UIView? {
    return self.scrollView
  }

  // MARK: Private

  @IBOutlet private weak var scrollView: RevertFocusableScrollView!
}

#if os(tvOS)
  extension ScrollViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      self.scrollView.panGestureRecognizer.allowedTouchTypes = [UITouchType.Indirect.rawValue]
    }
  }
#endif

final class RevertFocusableScrollView: UIScrollView {
  #if os(tvOS)
    override func canBecomeFocused() -> Bool {
      return true
    }
  #endif
}
