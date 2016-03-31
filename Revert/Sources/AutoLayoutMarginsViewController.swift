//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

private struct MarginValue {
  mutating func increment() {
    self.value = self.dynamicType.cappedMarginForMargin(self.value, delta: self.dynamicType.delta)
  }

  mutating func decrement() {
    self.value = self.dynamicType.cappedMarginForMargin(self.value, delta: -self.dynamicType.delta)
  }

  func layoutMarginsForCurrentValue() -> UIEdgeInsets {
    return UIEdgeInsets(top: self.value, left: self.value, bottom: self.value, right: self.value)
  }

  func currentValuePercentage() -> Float {
    return Float(self.value / self.dynamicType.maxValue)
  }

  func isMaximumValue() -> Bool {
    return self.value == self.dynamicType.maxValue
  }

  func isMinimumValue() -> Bool {
    return self.value == self.dynamicType.minValue
  }

  // MARK: Private
  private static let maxValue: CGFloat = 150
  private static let minValue: CGFloat = 0
  private static let delta: CGFloat = 10

  private(set) var value: CGFloat = 0 {
    didSet {
      self.progress.completedUnitCount = Int64(self.value)
    }
  }

  let progress = NSProgress(totalUnitCount:Int64(MarginValue.maxValue))

  private static func cappedMarginForMargin(margin: CGFloat, delta: CGFloat) -> CGFloat {
    let margin = margin + delta
    return margin < self.minValue ? self.minValue : min(margin, self.maxValue)
  }
}

class AutoLayoutMarginsViewController: RevertViewController {
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
  
  @IBOutlet private weak var centerViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var containerViewBottomConstraint: NSLayoutConstraint!

  private func updateSquareWidths() {
    let minDistance = min(self.containerView.bounds.width, self.containerView.bounds.height)
    let centerWidth = (minDistance - (4 * self.dynamicType.interSquareSpacing)) / 3
    self.centerViewWidthConstraint.constant = centerWidth
  }
}

#if os(tvOS)
final class ButtonsAutoLayoutMarginsViewController: AutoLayoutMarginsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.preferredFocusedButton = self.incrementButton

    self.progressView.observedProgress = self.margin.progress
    self.centerView.layoutMargins = self.margin.layoutMarginsForCurrentValue()
  }

  override var preferredFocusedView: UIView? {
    return self.preferredFocusedButton
  }

  //MARK: Private
  private var margin = MarginValue()
  private var preferredFocusedButton: UIView?

  @IBOutlet private weak var incrementButton: UIButton!
  @IBOutlet private weak var decrementButton: UIButton!
  @IBOutlet private weak var progressView: UIProgressView!
  
  @IBAction private func buttonPressed(sender: UIButton) {
    if sender == self.incrementButton {
      self.margin.increment()
    } else if sender == self.decrementButton {
      self.margin.decrement()
    }
    
    self.centerView.layoutMargins = self.margin.layoutMarginsForCurrentValue()

    self.updateStepButtonState(sender)
  }

  private func updateStepButtonState(sender: UIButton) {
    if sender == self.incrementButton {
      self.decrementButton.enabled = true

      if self.margin.isMaximumValue() {
        self.disableStepButton(sender)
      }
    } else if sender == self.decrementButton {
      self.incrementButton.enabled = true

      if self.margin.isMinimumValue() {
        self.disableStepButton(sender)
      }
    }
  }

  private func disableStepButton(button: UIButton) {
    button.enabled = false

    if button == self.incrementButton {
      self.preferredFocusedButton = self.decrementButton
    } else if button == self.decrementButton {
      self.preferredFocusedButton = self.incrementButton
    }

    setNeedsFocusUpdate()
    updateFocusIfNeeded()
  }
}
#endif

#if os(iOS)
final class SliderAutoLayoutMarginsViewController: AutoLayoutMarginsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.slider.value = 0
    self.slider.minimumValue = 0
    self.slider.maximumValue = 100
    self.centerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  // MARK: Private
  @IBOutlet private weak var slider: UISlider!
  
  @IBAction private func sliderValueChanged(sender: UISlider) {
    let margin = CGFloat(sender.value)
    self.centerView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
  }
}
#endif
