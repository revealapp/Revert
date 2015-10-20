//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AnchorPointBoundsChangeViewController: RevertViewController {
  @IBOutlet private weak var boundsChangeView: HairlineBorderView!
  @IBOutlet private weak var anchorPointView: HairlineBorderView!
  @IBOutlet private weak var scrollViewItemHeight: NSLayoutConstraint!

  private var wasAnimated = false
  
  private func animateIfNecessary() {
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true
    
    // Bounds Change testing
    let offset: CGFloat = -25
    UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: {
      self.boundsChangeView.bounds = CGRectOffset(self.boundsChangeView.bounds, offset, offset)
    }, completion: nil)
    
    // Anchor Point Testing

    let toValue = CGPoint(x: 0.25, y: 0.25)
    let basicAnimation = self.dynamicType.basicAnimationWithFromValue(self.anchorPointView.layer.anchorPoint, toValue: toValue)
    self.anchorPointView.layer.addAnimation(basicAnimation, forKey: "anchorPoint")
    self.anchorPointView.layer.anchorPoint = toValue
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateIfNecessary()
  }
  
  private let minimumItemHeight: CGFloat = 150
  private let numberOfItems = 2
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Update the scrollview' subview's height to match the screen height with a minimum value
    let scrollViewItemHeight = floor((self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length) / CGFloat(self.numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, self.minimumItemHeight)
  }
}

extension AnchorPointBoundsChangeViewController {
  private static func basicAnimationWithFromValue(fromValue: CGPoint, toValue: CGPoint) -> CABasicAnimation {
    let basicAnimation = CABasicAnimation(keyPath: "anchorPoint")
    basicAnimation.duration = 1
    basicAnimation.fromValue = NSValue(CGPoint: fromValue)
    basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    basicAnimation.toValue = NSValue(CGPoint: toValue)
    return basicAnimation
  }
}
