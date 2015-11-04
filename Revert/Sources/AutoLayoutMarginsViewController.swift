//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AutoLayoutMarginsViewController: RevertViewController {
  @IBOutlet private weak var centerView: UIView!
  @IBOutlet private weak var slider: UISlider!
  @IBOutlet private weak var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var containerViewBottomConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()

    if #available(iOS 8.0, *) {
      self.slider.value = 0
      self.slider.minimumValue = 0
      self.slider.maximumValue = 100
      self.centerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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

  private static let interSquareSpacing: CGFloat = 20

  private func updateSquareWidths() {
    let minDistance = min(self.containerView.bounds.width, self.containerView.bounds.height)
    let centerWidth = (minDistance - (4 * self.dynamicType.interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = centerWidth
  }

  @IBAction func sliderValueChanged(sender: UISlider) {
    if #available(iOS 8.0, *) {
      let margin = CGFloat(sender.value)
      self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
  }
}
