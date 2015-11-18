//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ModalViewController: RevertViewController {
  @IBAction private func dismiss(sender: UIBarButtonItem) {
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
