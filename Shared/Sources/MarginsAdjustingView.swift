//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

protocol MarginsAdjustingViewDelegate: class {
  func didUpdateMargins(updatedLayoutMargins: UIEdgeInsets)
}

class MarginsAdjustingView: UIView {
  weak var marginsDelegate: MarginsAdjustingViewDelegate?
}

#if os(iOS)
  final class SliderMarginsAdjustingView: MarginsAdjustingView {
    override func awakeFromNib() {
      super.awakeFromNib()

      self.slider.value = 0
      self.slider.minimumValue = 0
      self.slider.maximumValue = 100
    }

    // MARK: Private
    @IBOutlet private weak var slider: UISlider!

    @IBAction private func sliderValueChanged(sender: UISlider) {
      let margin = CGFloat(sender.value)
      self.marginsDelegate?.didUpdateMargins(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
    }
  }
#endif

#if os(tvOS)
  final class ButtonsMarginsAdjustingView: MarginsAdjustingView {
    override func awakeFromNib() {
      super.awakeFromNib()

      self.progressView.observedProgress = self.margin.progress
      self.decrementButton.enabled = false
      self.preferredFocusedButton = self.incrementButton
    }

    override var preferredFocusedView: UIView? {
      return self.preferredFocusedButton
    }

    // MARK: Private
    private var margin = MarginValue()
    private var preferredFocusedButton: UIView?

    @IBOutlet private var incrementButton: UIButton!
    @IBOutlet private var decrementButton: UIButton!
    @IBOutlet private var progressView: UIProgressView!

    @IBAction private func buttonPressed(sender: UIButton) {
      self.margin.changeValue(sender == self.incrementButton ? .Increment : .Decrement)

      self.marginsDelegate?.didUpdateMargins(self.margin.layoutMarginsForCurrentValue)

      self.updateStepButtonState(sender)
    }

    private func updateStepButtonState(sender: UIButton) {
      if sender == self.incrementButton {
        self.decrementButton.enabled = true

        if self.margin.isOnUpperLimit {
          self.disableStepButton(sender)
        }
      } else if sender == self.decrementButton {
        self.incrementButton.enabled = true

        if self.margin.isOnLowerLimit {
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

      self.setNeedsFocusUpdate()
      self.updateFocusIfNeeded()
    }
  }

  private struct MarginValue {
    mutating func changeValue(changeType: ChangeType) {
      let computedDelta = CGFloat(changeType.rawValue) * self.dynamicType.delta
      self.value = self.dynamicType.cappedMarginForMargin(self.value, delta: computedDelta)
    }

    enum ChangeType: Int {
      case Decrement = -1
      case Increment = 1
    }

    let progress = NSProgress(totalUnitCount:Int64(MarginValue.maxValue))

    var isOnUpperLimit: Bool {
      return self.value == self.dynamicType.maxValue
    }

    var isOnLowerLimit: Bool {
      return self.value == self.dynamicType.minValue
    }

    var layoutMarginsForCurrentValue: UIEdgeInsets {
      return UIEdgeInsets(top: self.value, left: self.value, bottom: self.value, right: self.value)
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

    private static func cappedMarginForMargin(margin: CGFloat, delta: CGFloat) -> CGFloat {
      let margin = margin + delta
      return margin < self.minValue ? self.minValue : min(margin, self.maxValue)
    }
  }
#endif
