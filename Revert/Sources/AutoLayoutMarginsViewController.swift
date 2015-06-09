//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoLayoutMarginsViewController: RevertViewController {
  @IBOutlet weak var centerView: UIView!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.centerView.respondsToSelector("layoutMargins") {
      self.slider.value = 0
      self.slider.minimumValue = 0
      self.slider.maximumValue = 100
      if #available(iOS 8.0, *) {
          self.centerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
    } else {
      self.slider.hidden = true
      self.containerViewBottomConstraint.constant = 0
    }
  }
  
  private var lastUpdateSquaresWidthSize: CGSize?

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if self.containerView.bounds.size != self.lastUpdateSquaresWidthSize {
      self.updateSquareWidths()
      self.lastUpdateSquaresWidthSize = self.containerView.bounds.size
    }
  }
  
  private let interSquareSpacing: CGFloat = 20

  private func updateSquareWidths() {
    let minDistance = min(self.containerView.bounds.width, self.containerView.bounds.height)
    let centerWidth = (minDistance - (4 * self.interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = centerWidth
  }
  
  @IBAction func sliderValueChanged(sender: UISlider) {
    if self.centerView.respondsToSelector("layoutMargins") {
      let margin = CGFloat(sender.value)
      if #available(iOS 8.0, *) {
          self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
      }
    }
  }
}
