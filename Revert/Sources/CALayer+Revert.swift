//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

extension CALayer {
  
  var borderUIColor: UIColor! {
    set {
      self.borderColor = newValue.CGColor
    }
    get {
      return UIColor(CGColor: self.borderColor)
    }
  }
}
