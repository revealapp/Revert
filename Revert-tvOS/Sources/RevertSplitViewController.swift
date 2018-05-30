//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class RevertSplitViewController: UISplitViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.setNeedsFocusUpdate()
    self.updateFocusIfNeeded()
  }

  func focusDetailView() {
    self.preferDetailViewFocus = true

    self.setNeedsFocusUpdate()
    self.updateFocusIfNeeded()
  }

  override var preferredFocusedView: UIView? {
    var preferredView: UIView? = super.preferredFocusedView

    if self.preferDetailViewFocus {
      self.preferDetailViewFocus = false

      preferredView = self.viewControllers.last?.preferredFocusedView
    }

    return preferredView
  }

  // MARK: - Private

  private var preferDetailViewFocus = false
}
