//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ModalViewController: RevertViewController {

  @IBAction private func dismiss(_ sender: UIBarButtonItem) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
}
