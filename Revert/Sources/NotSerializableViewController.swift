//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class NonSerializableViewController: RevertViewController {
  @IBOutlet private weak var progressView: UIProgressView!
  @IBOutlet private weak var subView: UIView!
  @IBOutlet private weak var slider: UISlider!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.slider.addTarget(self, action: "warnBeforeCrash:", forControlEvents: .TouchUpInside)
  }

  func warnBeforeCrash(sender: UISlider?) {
    let alertTitle = NSLocalizedString("Modifying the UISlider again will cause the app to crash", comment: "Unserializable slider title")
    let alertMessage = NSLocalizedString("This is intentional, and demonstrates what happens when a property is not serializable.", comment: "Unserializable slider message")

    if #available(iOS 8.0, *) {
      let alertViewController = UIAlertController(
        title: alertTitle,
        message: alertMessage,
        preferredStyle: .Alert
      )

      let continueAction = UIAlertAction(
        title: NSLocalizedString("Ok", comment: "Alert Ok button title"),
        style: .Default) { [weak self] _ in
          self?.makeSliderUnserializable(self)

          // Only show the alert once
          self?.slider.removeTarget(self, action: "warnBeforeCrash:", forControlEvents: .TouchUpInside)
      }

      alertViewController.addAction(continueAction)

      self.presentViewController(alertViewController, animated: true, completion: nil)
    } else {
      let alertView = UIAlertView(
        title: alertTitle,
        message: alertMessage,
        delegate: nil,
        cancelButtonTitle: NSLocalizedString("OK", comment: "Unserializable slider OK button")
      )

      alertView.show()
    }

  }

  private func makeSliderUnserializable(viewController: NonSerializableViewController?) {
    // inf
    viewController?.slider.maximumValue = 1 / 0

    // nan
    viewController?.progressView.contentScaleFactor = 0 / 0

    // - inf
    viewController?.subView.contentScaleFactor = -1 / 0
  }
}

extension NonSerializableViewController: UIAlertViewDelegate {

  func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
    makeSliderUnserializable(self)

    // Only show the alert once
    self.slider.removeTarget(self, action: "warnBeforeCrash:", forControlEvents: .TouchUpInside)
  }

}
