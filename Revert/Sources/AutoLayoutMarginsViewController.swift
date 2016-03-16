//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AutoLayoutMarginsViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.slider.value = 0
    self.slider.minimumValue = 0
    self.slider.maximumValue = 100
    self.centerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if self.containerView.bounds.size != self.lastUpdateSquaresWidthSize {
      self.updateSquareWidths()
      self.lastUpdateSquaresWidthSize = self.containerView.bounds.size
    }
  }

  // MARK: Private

  private static let interSquareSpacing: CGFloat = 20

  private var lastUpdateSquaresWidthSize: CGSize?

  @IBOutlet private weak var centerView: UIView!
  @IBOutlet private weak var slider: UISlider!
  @IBOutlet private weak var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var containerViewBottomConstraint: NSLayoutConstraint!

  @IBAction private func sliderValueChanged(sender: UISlider) {
    let margin = CGFloat(sender.value)
    self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
  }

  private func updateSquareWidths() {
    let minDistance = min(self.containerView.bounds.width, self.containerView.bounds.height)
    let centerWidth = (minDistance - (4 * self.dynamicType.interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = centerWidth
  }
}
