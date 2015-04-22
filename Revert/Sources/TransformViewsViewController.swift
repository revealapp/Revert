//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TransformViewsViewController: UIViewController {
  
  @IBOutlet weak var translateView: UIView!
  @IBOutlet weak var rotateView: UIView!
  @IBOutlet weak var scaleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.translateView.transform = CGAffineTransformMakeTranslation(-20.0, 20.0)
    self.rotateView.transform = CGAffineTransformMakeRotation(CGFloat(15.0 * M_PI / 180.0))
    self.scaleView.transform = CGAffineTransformMakeScale(0.5, 0.5)
  }
}
