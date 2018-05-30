//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

@available(iOS 9.0, *)
final class StackViewController: RevertViewController {

  override func loadView() {
    let nib = Bundle.main.loadNibNamed("StackView", owner: self, options: nil)
    guard let view = nib?.first as? UIView else {
      fatalError("Could not load Stack View from xib")
    }

    self.view = view
  }
}
