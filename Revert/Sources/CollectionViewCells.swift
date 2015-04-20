//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TextFieldControlCell: UICollectionViewCell {
  @IBAction func textFieldDidEndOnExit(sender: UITextField) {
    sender.resignFirstResponder()
  }
}
