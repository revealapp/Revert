//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HairlineBorderView: UIView {
  override func awakeFromNib() {
    super.awakeFromNib()

    self.layer.borderWidth = 1 / UIScreen.mainScreen().scale
  }
}
