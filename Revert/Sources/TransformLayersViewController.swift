//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import GLKit

final class TransformLayersViewController: RevertViewController {
  @IBOutlet weak var yRotateView: UIView!
  @IBOutlet weak var xRotateView: UIView!
  @IBOutlet weak var zRotateView: UIView!
  @IBOutlet weak var xyRotateView: UIView!
  @IBOutlet weak var scrollViewItemHeight: NSLayoutConstraint!
  
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
  
  private let minItemHeight: CGFloat = 150

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Update the scrollview' subview's height to match the screen height with a minimum value
    let scrollViewItemHeight = floor(self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length) / 4
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, self.minItemHeight)
  }
}

