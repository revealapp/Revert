//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CustomIntrinsicContentSizeView: UIView {
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: 80.0, height: 80.0)
  }
}

final class AutoLayoutMarginsViewController: ViewController {
  @IBOutlet weak var centerView: UIView!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!

  private let interSquareSpacing: CGFloat = 40
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if self.centerView.respondsToSelector("layoutMargins") {
      self.slider.minimumValue = Float(self.centerView.layoutMargins.top)
      self.slider.value = self.slider.minimumValue
      self.slider.maximumValue = self.slider.minimumValue + 100.0
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let spacingWidth = (min(self.containerView.frame.width, self.containerView.frame.height) - (2 * self.interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = spacingWidth
  }
  
  private var hasDisplayedHelp = false
  
  @IBAction func sliderValueChanged(sender: UISlider) {
    if self.centerView.respondsToSelector("layoutMargins") {
      let margin = CGFloat(sender.value)
      self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    } else if self.hasDisplayedHelp == false {
      self.hasDisplayedHelp = true
    }
  }
}
