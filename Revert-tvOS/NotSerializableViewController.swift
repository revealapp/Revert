//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class NonSerializableViewController: RevertViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.infAlphaView.alpha = 1/0
    self.nanAlphaView.alpha = 0/0
  }
  
  // Mark: Private
  @IBOutlet private weak var infAlphaView: UIView!
  @IBOutlet private weak var nanAlphaView: UIView!
}
