//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension CALayer {
  var borderUIColor: UIColor! {
    set {
      self.borderColor = newValue.cgColor
    }
    get {
      return UIColor(cgColor: self.borderColor!)
    }
  }
}
