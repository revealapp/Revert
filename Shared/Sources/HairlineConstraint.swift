//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HairlineConstraint: NSLayoutConstraint {
  override func awakeFromNib() {
    super.awakeFromNib()

    self.constant = type(of: self).constantValue
  }

  // MARK: Private

  fileprivate static var constantValue: CGFloat {
    return 1 / UIScreen.main.scale
  }
}
