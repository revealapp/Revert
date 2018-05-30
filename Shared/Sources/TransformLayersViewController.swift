//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import GLKit
import UIKit

final class TransformLayersViewController: RevertViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.animateViewsIfNecessarry()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    let rotationInRadians = CGFloat(GLKMathDegreesToRadians(10))

    // Update the scrollview' subview's height to match the screen height with a minimum value and accounts for extra height after xy rotation
    let xyRotationPadding = sqrt((2 * self.xyRotateView.frame.size.width / 2 * self.xyRotateView.frame.size.width / 2) * (1 - cos(rotationInRadians)))
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length - xyRotationPadding
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(type(of: self).numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, type(of: self).minimumItemHeight)
  }

  // MARK: Private

  private static let minimumItemHeight: CGFloat = 150
  private static let numberOfItems = 4

  private var wasAnimated = false

  @IBOutlet private var yRotateView: UIView!
  @IBOutlet private var xRotateView: UIView!
  @IBOutlet private var zRotateView: UIView!
  @IBOutlet private var xyRotateView: UIView!
  @IBOutlet private var scrollViewItemHeight: NSLayoutConstraint!

  private func animateViewsIfNecessarry() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true

    let fortyFiveDegreesInRadian = CGFloat(GLKMathDegreesToRadians(45))
    let tenDegreesInRadian = CGFloat(GLKMathDegreesToRadians(10))

    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: {
      self.xRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 1, 0, 0)
      self.yRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0, 1, 0)
      self.zRotateView.layer.transform = CATransform3DMakeRotation(tenDegreesInRadian, 0, 0, 1)
      self.xyRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0.6, 0.4, 0)
    }, completion: nil)
  }
}
