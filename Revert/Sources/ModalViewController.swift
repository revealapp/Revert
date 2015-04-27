//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
  @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
  }
}
