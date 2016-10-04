//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

protocol MarginsAdjustingViewDelegate: class {
  func didUpdateMargins(_ updatedLayoutMargins: UIEdgeInsets)
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
    @IBOutlet fileprivate weak var slider: UISlider!

    @IBAction fileprivate func sliderValueChanged(_ sender: UISlider) {
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
      self.decrementButton.isEnabled = false
      self.preferredFocusedButton = self.incrementButton
    }

    override var preferredFocusedView: UIView? {
      return self.preferredFocusedButton
    }

    // MARK: Private
    fileprivate var margin = MarginValue()
    fileprivate var preferredFocusedButton: UIView?

    @IBOutlet fileprivate var incrementButton: UIButton!
    @IBOutlet fileprivate var decrementButton: UIButton!
    @IBOutlet fileprivate var progressView: UIProgressView!

    @IBAction fileprivate func buttonPressed(_ sender: UIButton) {
      self.margin.changeValue(sender == self.incrementButton ? .increment : .decrement)

      self.marginsDelegate?.didUpdateMargins(self.margin.layoutMarginsForCurrentValue)

      self.updateStepButtonState(sender)
    }

    fileprivate func updateStepButtonState(_ sender: UIButton) {
      if sender == self.incrementButton {
        self.decrementButton.isEnabled = true

        if self.margin.isOnUpperLimit {
          self.disableStepButton(sender)
        }
      } else if sender == self.decrementButton {
        self.incrementButton.isEnabled = true

        if self.margin.isOnLowerLimit {
          self.disableStepButton(sender)
        }
      }
    }

    fileprivate func disableStepButton(_ button: UIButton) {
      button.isEnabled = false

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
    mutating func changeValue(_ changeType: ChangeType) {
      let computedDelta = CGFloat(changeType.rawValue) * type(of: self).delta
      self.value = type(of: self).cappedMarginForMargin(self.value, delta: computedDelta)
    }

    enum ChangeType: Int {
      case decrement = -1
      case increment = 1
    }

    let progress = Progress(totalUnitCount:Int64(MarginValue.maxValue))

    var isOnUpperLimit: Bool {
      return self.value == type(of: self).maxValue
    }

    var isOnLowerLimit: Bool {
      return self.value == type(of: self).minValue
    }

    var layoutMarginsForCurrentValue: UIEdgeInsets {
      return UIEdgeInsets(top: self.value, left: self.value, bottom: self.value, right: self.value)
    }

    // MARK: Private
    fileprivate static let maxValue: CGFloat = 150
    fileprivate static let minValue: CGFloat = 0
    fileprivate static let delta: CGFloat = 10

    fileprivate(set) var value: CGFloat = 0 {
      didSet {
        self.progress.completedUnitCount = Int64(self.value)
      }
    }

    fileprivate static func cappedMarginForMargin(_ margin: CGFloat, delta: CGFloat) -> CGFloat {
      let margin = margin + delta
      return margin < self.minValue ? self.minValue : min(margin, self.maxValue)
    }
  }
#endif
