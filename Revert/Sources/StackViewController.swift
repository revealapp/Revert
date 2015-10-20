//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
class StackViewController : RevertViewController {
  override func loadView() {
    let nib = NSBundle.mainBundle().loadNibNamed("StackView", owner: self, options: nil)
    guard let view = nib.first as? UIView else {
      fatalError("Could not load Stack View from xib")
    }
    
    self.view = view
  }
}
