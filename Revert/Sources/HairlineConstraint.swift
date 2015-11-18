//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HairlineConstraint: NSLayoutConstraint {
  override func awakeFromNib() {
    super.awakeFromNib()

    self.constant = self.dynamicType.constantValue
  }

  // MARK: Private

  private static var constantValue: CGFloat {
    return 1 / UIScreen.mainScreen().scale
  }
}
