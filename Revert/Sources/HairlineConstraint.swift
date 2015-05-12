//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class HairlineConstraint: NSLayoutConstraint {
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.constant = self.dynamicType.constantValue
  }
  
  private class var constantValue: CGFloat {
    return 1.0 / UIScreen.mainScreen().scale
  }
}