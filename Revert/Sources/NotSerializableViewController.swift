//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class NonSerializableViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.labelTrailingConstraint.constant = CGFloat.min

    self.slider.addTarget(self, action: #selector(self.warnBeforeCrash(_:)), forControlEvents: .TouchUpInside)
    self.slider.addTarget(self, action: #selector(self.warnBeforeCrash(_:)), forControlEvents: .TouchUpOutside)
  }

  func warnBeforeCrash(sender: UISlider?) {
    let alertTitle = NSLocalizedString("Modifying the UISlider again will cause the app to crash", comment: "Unserializable slider title")
    let alertMessage = NSLocalizedString("This is intentional, and demonstrates what happens when a property is not serializable.", comment: "Unserializable slider message")

    let alertViewController = UIAlertController(
      title: alertTitle,
      message: alertMessage,
      preferredStyle: .Alert
    )

    let continueAction = UIAlertAction(
      title: NSLocalizedString("Ok", comment: "Alert Ok button title"),
      style: .Default) { [weak self] _ in
        self?.makeSliderUnserializable()

        // Only show the alert once
        self?.slider.removeTarget(self, action: #selector(self?.warnBeforeCrash(_:)), forControlEvents: .TouchUpInside)
        self?.slider.removeTarget(self, action: #selector(self?.warnBeforeCrash(_:)), forControlEvents: .TouchUpOutside)
    }

    alertViewController.addAction(continueAction)

    self.presentViewController(alertViewController, animated: true, completion: nil)
  }

  // MARK: Private

  @IBOutlet private var progressView: UIProgressView!
  @IBOutlet private var subView: UIView!
  @IBOutlet private var slider: UISlider!
  @IBOutlet private var labelTrailingConstraint: NSLayoutConstraint!

  private func makeSliderUnserializable() {
    // inf
    self.slider.maximumValue = 1 / 0

    // nan
    self.progressView.contentScaleFactor = 0 / 0

    // - inf
    self.subView.contentScaleFactor = -1 / 0
  }
}
