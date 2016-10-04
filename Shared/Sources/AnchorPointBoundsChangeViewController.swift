//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AnchorPointBoundsChangeViewController: RevertViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.animateIfNecessary()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    // Update the scrollview' subview's height to match the screen height with a minimum value
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(type(of: self).numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, type(of: self).minimumItemHeight)

    if let boundsOffset = Static.Formatter.decimal.string(from: -self.quarterBoundsHeight as NSNumber) {
      self.boundsChangeLabel.text = NSLocalizedString("Bounds Change: (\(boundsOffset), \(boundsOffset))", comment: "Bounds change description")
    }

    if let anchorOffsetX = Static.Formatter.decimal.string(from: type(of: self).anchorOffset.x as NSNumber),
      let anchorOffsetY = Static.Formatter.decimal.string(from: type(of: self).anchorOffset.y as NSNumber) {
      self.anchorChangeLabel.text = NSLocalizedString("Anchor Point: (\(anchorOffsetX), \(anchorOffsetY))", comment: "Anchor point description")
    }
  }

  // MARK: Private

  fileprivate static let anchorOffset = CGPoint(x: 0.25, y: 0.25)
  fileprivate static let minimumItemHeight: CGFloat = 150
  fileprivate static let numberOfItems = 2

  fileprivate var wasAnimated = false

  fileprivate lazy var quarterBoundsHeight: CGFloat = {
    return self.boundsChangeView.frame.height / 4
  }()

  @IBOutlet fileprivate var boundsChangeView: HairlineBorderView!
  @IBOutlet fileprivate var anchorPointView: HairlineBorderView!
  @IBOutlet fileprivate var scrollViewItemHeight: NSLayoutConstraint!
  @IBOutlet fileprivate var boundsChangeLabel: UILabel!
  @IBOutlet fileprivate var anchorChangeLabel: UILabel!

  fileprivate func animateIfNecessary() {
    if self.wasAnimated {
      return
    }

    self.wasAnimated = true

    // Bounds Change testing
    let offset: CGFloat = -self.quarterBoundsHeight
    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: {
      self.boundsChangeView.bounds = self.boundsChangeView.bounds.offsetBy(dx: offset, dy: offset)
      }, completion: nil)

    // Anchor Point Testing

    let basicAnimation = type(of: self).basicAnimationWithFromValue(self.anchorPointView.layer.anchorPoint, toValue: type(of: self).anchorOffset)
    self.anchorPointView.layer.add(basicAnimation, forKey: "anchorPoint")
    self.anchorPointView.layer.anchorPoint = type(of: self).anchorOffset
  }
}

private extension AnchorPointBoundsChangeViewController {
  static func basicAnimationWithFromValue(_ fromValue: CGPoint, toValue: CGPoint) -> CABasicAnimation {
    let basicAnimation = CABasicAnimation(keyPath: "anchorPoint")
    basicAnimation.duration = 1
    basicAnimation.fromValue = NSValue(cgPoint: fromValue)
    basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    basicAnimation.toValue = NSValue(cgPoint: toValue)
    return basicAnimation
  }
}
