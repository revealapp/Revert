//
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

  fileprivate static let minimumItemHeight: CGFloat = 150
  fileprivate static let numberOfItems = 3

  fileprivate var wasAnimated = false

  @IBOutlet fileprivate weak var translateView: UIView!
  @IBOutlet fileprivate weak var rotateView: UIView!
  @IBOutlet fileprivate weak var scaleView: UIView!
  @IBOutlet fileprivate weak var scrollViewItemHeight: NSLayoutConstraint!

  fileprivate func animateViewsIfNecessary() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }

    self.wasAnimated = true

    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
      self.translateView.transform = CGAffineTransform(translationX: -20, y: 20)
      self.rotateView.transform = CGAffineTransform(rotationAngle: CGFloat(15 * M_PI / 180))
      self.scaleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }, completion: nil)
  }
}
