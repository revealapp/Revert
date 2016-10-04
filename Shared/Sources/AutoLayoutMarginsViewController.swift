//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AutoLayoutMarginsViewController: RevertViewController, MarginsAdjustingViewDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.marginsAdjustingView.marginsDelegate = self

    self.centerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if self.containerView.bounds.size != self.lastUpdateSquaresWidthSize {
      self.updateSquareWidths()
      self.lastUpdateSquaresWidthSize = self.containerView.bounds.size
    }
  }

  // MARK: MarginsAdjustingViewDelegate
  func didUpdateMargins(_ updatedLayoutMargins: UIEdgeInsets) {
    self.centerView.layoutMargins = updatedLayoutMargins
  }

  // MARK: Private
  fileprivate static let interSquareSpacing: CGFloat = 20

  fileprivate var lastUpdateSquaresWidthSize: CGSize?

  @IBOutlet fileprivate var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet fileprivate var containerViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet fileprivate var marginsAdjustingView: MarginsAdjustingView!
  @IBOutlet fileprivate var centerView: UIView!
  @IBOutlet fileprivate var containerView: UIView!

  fileprivate func updateSquareWidths() {
    let minDistance = min(self.containerView.bounds.width, self.containerView.bounds.height)
    let centerWidth = (minDistance - (4 * type(of: self).interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = centerWidth
  }
}

#if os(tvOS)

  extension AutoLayoutMarginsViewController {
    override var preferredFocusedView: UIView? {
      return self.marginsAdjustingView
    }
  }
#endif
