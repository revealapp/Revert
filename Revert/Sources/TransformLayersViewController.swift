//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TransformLayersViewController: UIViewController {
  @IBOutlet weak var yRotateView: UIView!
  @IBOutlet weak var xRotateView: UIView!
  @IBOutlet weak var zRotateView: UIView!
  @IBOutlet weak var xyRotateView: UIView!
  
  private var isFirstAppear = true
  
  private func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
  }
  
  private func animateIfNecessarry() {
    if self.isFirstAppear {
      self.isFirstAppear = false

      let fortyFiveDegreesInRadian = self.degreesToRadians(45.0)
      let tenDegreesInRadian = self.degreesToRadians(10.0)

      UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
        // Top Views
        self.xRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 1.0, 0.0, 0.0)
        self.yRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0.0, 1.0, 0.0)
        self.zRotateView.layer.transform = CATransform3DMakeRotation(tenDegreesInRadian, 0.0, 0.0, 1.0)
        self.xyRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0.5, 0.5, 0.0)
      }, completion: nil)
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
   
    self.animateIfNecessarry()
  }
}
