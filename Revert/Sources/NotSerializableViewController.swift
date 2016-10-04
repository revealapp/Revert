//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class NonSerializableViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.labelTrailingConstraint.constant = CGFloat.leastNormalMagnitude

    self.stepper.minimumValue = -DBL_MAX
    self.stepper.maximumValue = DBL_MAX

    self.slider.addTarget(self, action: #selector(self.warnBeforeCrash(_:)), for: .touchUpInside)
    self.slider.addTarget(self, action: #selector(self.warnBeforeCrash(_:)), for: .touchUpOutside)
  }

  func warnBeforeCrash(_ sender: UISlider?) {
    let alertTitle = NSLocalizedString("Modifying the UISlider again will cause the app to crash", comment: "Unserializable slider title")
    let alertMessage = NSLocalizedString("This is intentional, and demonstrates what happens when a property is not serializable.", comment: "Unserializable slider message")

    let alertViewController = UIAlertController(
      title: alertTitle,
      message: alertMessage,
      preferredStyle: .alert
    )

    let continueAction = UIAlertAction(
      title: NSLocalizedString("Ok", comment: "Alert Ok button title"),
      style: .default) { [weak self] _ in
      self?.makeSliderUnserializable()

      // Only show the alert once
      self?.slider.removeTarget(self, action: #selector(self?.warnBeforeCrash(_:)), for: .touchUpInside)
      self?.slider.removeTarget(self, action: #selector(self?.warnBeforeCrash(_:)), for: .touchUpOutside)
    }

    alertViewController.addAction(continueAction)

    self.present(alertViewController, animated: true, completion: nil)
  }

  // MARK: Private

  @IBOutlet fileprivate var progressView: UIProgressView!
  @IBOutlet fileprivate var subView: UIView!
  @IBOutlet fileprivate var slider: UISlider!
  @IBOutlet fileprivate var stepper: UIStepper!
  @IBOutlet fileprivate var labelTrailingConstraint: NSLayoutConstraint!

  fileprivate func makeSliderUnserializable() {
    // inf
    self.slider.maximumValue = 1 / 0

    // nan
    self.progressView.contentScaleFactor = 0 / 0

    // - inf
    self.subView.contentScaleFactor = -1 / 0
  }
}
