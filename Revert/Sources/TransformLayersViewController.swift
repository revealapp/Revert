//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TransformLayersViewController: UIViewController {
  @IBOutlet weak var translateView: UIView!
  @IBOutlet weak var rotateView: UIView!
  @IBOutlet weak var scaleView: UIView!
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateViews()
  }
  
  
  private func animateViews() {
    UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
      self.rotateView.layer.transform = CATransform3DMakeRotation(CGFloat(30.0 * M_PI / 180.0), 1.0, 0.0, 0.0)
    }, completion: nil)
  }
}
