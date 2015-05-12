//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class ModalViewController: ViewController {
  @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
  }
}
