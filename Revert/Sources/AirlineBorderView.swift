//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AirlineBorderView: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.layer.borderWidth = 1.0 / UIScreen.mainScreen().nativeScale
  }
}
