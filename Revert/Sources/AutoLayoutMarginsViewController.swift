//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CustomIntrinsicContentSizeView: UIView {
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: 80.0, height: 80.0)
  }
}

final class AutoLayoutMarginsViewController: UIViewController {
  @IBOutlet weak var centerView: UIView!
  @IBOutlet weak var slider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.slider.minimumValue = Float(self.centerView.layoutMargins.top)
    self.slider.value = self.slider.minimumValue
    self.slider.maximumValue = self.slider.minimumValue + 100.0
  }
  
  @IBAction func sliderValueChanged(sender: UISlider) {
    let margin = CGFloat(sender.value)
    self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
  }
}
