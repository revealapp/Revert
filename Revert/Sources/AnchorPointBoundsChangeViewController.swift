//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AnchorPointBoundsChangeViewController: RevertViewController {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    self.animateIfNecessary()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    // Update the scrollview' subview's height to match the screen height with a minimum value
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(self.dynamicType.numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, self.dynamicType.minimumItemHeight)

    if let boundsOffset = Static.Formatter.decimal.stringFromNumber(-self.quarterBoundsHeight) {
      self.boundsChangeLabel.text = NSLocalizedString("Bounds Change: (\(boundsOffset), \(boundsOffset))", comment: "Bounds change description")
    }

    if let anchorOffsetX = Static.Formatter.decimal.stringFromNumber(self.dynamicType.anchorOffset.x),
      let anchorOffsetY = Static.Formatter.decimal.stringFromNumber(self.dynamicType.anchorOffset.y) {
      self.anchorChangeLabel.text = NSLocalizedString("Anchor Point: (\(anchorOffsetX), \(anchorOffsetY))", comment: "Anchor point description")
    }
  }

  // MARK: Private

  private static let anchorOffset = CGPoint(x: 0.25, y: 0.25)
  private static let minimumItemHeight: CGFloat = 150
  private static let numberOfItems = 2

  private var wasAnimated = false

  private lazy var quarterBoundsHeight: CGFloat = {
    return self.boundsChangeView.frame.height / 4
  }()

  @IBOutlet private var boundsChangeView: HairlineBorderView!
  @IBOutlet private var anchorPointView: HairlineBorderView!
  @IBOutlet private var scrollViewItemHeight: NSLayoutConstraint!
  @IBOutlet private var boundsChangeLabel: UILabel!
  @IBOutlet private var anchorChangeLabel: UILabel!

  private func animateIfNecessary() {
    if self.wasAnimated {
      return
    }

    self.wasAnimated = true

    // Bounds Change testing
    let offset: CGFloat = -self.quarterBoundsHeight
    UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: {
      self.boundsChangeView.bounds = CGRectOffset(self.boundsChangeView.bounds, offset, offset)
      }, completion: nil)

    // Anchor Point Testing

    let basicAnimation = self.dynamicType.basicAnimationWithFromValue(self.anchorPointView.layer.anchorPoint, toValue: self.dynamicType.anchorOffset)
    self.anchorPointView.layer.addAnimation(basicAnimation, forKey: "anchorPoint")
    self.anchorPointView.layer.anchorPoint = self.dynamicType.anchorOffset
  }
}

private extension AnchorPointBoundsChangeViewController {
  static func basicAnimationWithFromValue(fromValue: CGPoint, toValue: CGPoint) -> CABasicAnimation {
    let basicAnimation = CABasicAnimation(keyPath: "anchorPoint")
    basicAnimation.duration = 1
    basicAnimation.fromValue = NSValue(CGPoint: fromValue)
    basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    basicAnimation.toValue = NSValue(CGPoint: toValue)
    return basicAnimation
  }
}
