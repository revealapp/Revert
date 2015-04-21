//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AutoLayoutMarginsViewController: UIViewController {
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var centerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.stepper.value = Double(self.centerView.layoutMargins.top)
  }
  
  @IBAction func stepperChanged(sender: UIStepper) {
    let margin = CGFloat(sender.value)
    self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
  }
}

class CustomIntrinsicContentSizeView: UIView {
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: 80.0, height: 80.0)
  }
}
