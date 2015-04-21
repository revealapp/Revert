//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return self.layer.cornerRadius
    }
    set {
      self.layer.cornerRadius = newValue
    }
  }

  @IBInspectable var borderWidth: CGFloat {
    get {
      return self.layer.borderWidth
    }
    set {
      self.layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor {
    get {
      return UIColor(CGColor: self.layer.borderColor)!
    }
    set {
      self.layer.borderColor = newValue.CGColor
    }
  }
}
