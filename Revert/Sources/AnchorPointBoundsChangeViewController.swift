//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AnchorPointBoundsChangeViewController: ViewController {
  @IBOutlet weak var boundsChangeView: HairlineBorderView!
  @IBOutlet weak var anchorPointView: HairlineBorderView!
  @IBOutlet weak var scrollViewItemHeight: NSLayoutConstraint!

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
    let basicAnimation = CABasicAnimation(keyPath: "anchorPoint")
    basicAnimation.duration = 1
    basicAnimation.fromValue = NSValue(CGPoint: self.anchorPointView.layer.anchorPoint)
    basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    basicAnimation.toValue = NSValue(CGPoint: toValue)
    self.anchorPointView.layer.addAnimation(basicAnimation, forKey: "anchorPoint")
    self.anchorPointView.layer.anchorPoint = toValue
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateIfNecessary()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let scrollViewItemHeight = floor(self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length) / 2
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, 200)
  }
}
