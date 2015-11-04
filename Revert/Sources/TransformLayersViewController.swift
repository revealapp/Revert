//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

final class TransformLayersViewController: RevertViewController {
  @IBOutlet private weak var yRotateView: UIView!
  @IBOutlet private weak var xRotateView: UIView!
  @IBOutlet private weak var zRotateView: UIView!
  @IBOutlet private weak var xyRotateView: UIView!
  @IBOutlet private weak var scrollViewItemHeight: NSLayoutConstraint!
  
  private var wasAnimated = false

  private func animateViewsIfNecessarry() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true

    let fortyFiveDegreesInRadian = CGFloat(GLKMathDegreesToRadians(45))
    let tenDegreesInRadian = CGFloat(GLKMathDegreesToRadians(10))

    UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: {
      self.xRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 1, 0, 0)
      self.yRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0, 1, 0)
      self.zRotateView.layer.transform = CATransform3DMakeRotation(tenDegreesInRadian, 0, 0, 1)
      self.xyRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0.5, 0.5, 0)
    }, completion: nil)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
   
    self.animateViewsIfNecessarry()
  }
  
  private static let minimumItemHeight: CGFloat = 150
  private static let numberOfItems = 4

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Update the scrollview' subview's height to match the screen height with a minimum value
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(self.dynamicType.numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, self.dynamicType.minimumItemHeight)
  }
}
