//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class TransformViewsViewController: RevertViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.animateViewsIfNecessary()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    // Update the scrollview' subview's height to match the screen height with a minimum value
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(type(of: self).numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, type(of: self).minimumItemHeight)
  }

  // MARK: Private

  private static let minimumItemHeight: CGFloat = 150
  private static let numberOfItems = 3

  private var wasAnimated = false

  @IBOutlet private var translateView: UIView!
  @IBOutlet private var rotateView: UIView!
  @IBOutlet private var scaleView: UIView!
  @IBOutlet private var scrollViewItemHeight: NSLayoutConstraint!

  private func animateViewsIfNecessary() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }

    self.wasAnimated = true

    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
      self.translateView.transform = CGAffineTransform(translationX: -20, y: 20)
      self.rotateView.transform = CGAffineTransform(rotationAngle: 15.0 * .pi / 180.0)
      self.scaleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }, completion: nil)
  }
}
