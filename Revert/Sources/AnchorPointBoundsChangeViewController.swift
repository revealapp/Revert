//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class AnchorPointBoundsChangeViewController: UIViewController, SettableMasterItem {
  @IBOutlet weak var boundsChangeView: HairlineBorderView!
  @IBOutlet weak var anchorPointView: HairlineBorderView!
  var item: MasterItem?

  private var wasAnimated = false
  
  private func animateIfNecessary() {
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true
    
    // Bounds Change testing
    let offset: CGFloat = -25.0
    UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
      self.boundsChangeView.bounds = CGRectOffset(self.boundsChangeView.bounds, offset, offset)
      }, completion: nil)
    
    // Anchor Point Testing
    let toValue = CGPoint(x: 0.25, y: 0.25)
    let basicAnimation = CABasicAnimation(keyPath: "anchorPoint")
    basicAnimation.duration = 1.0
    basicAnimation.fromValue = NSValue(CGPoint: self.anchorPointView.layer.anchorPoint)
    basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    basicAnimation.toValue = NSValue(CGPoint: toValue)
    self.anchorPointView.layer.addAnimation(basicAnimation, forKey: "anchorPoint")
    self.anchorPointView.layer.anchorPoint = toValue
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateIfNecessary()
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}
