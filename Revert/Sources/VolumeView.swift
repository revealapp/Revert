//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import MediaPlayer

class VolumeView: MPVolumeView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
   
    // This removes the entrance animation of MPVolumeView on iOS8 whereby
    // the view animates from frame CGRectZero to final frame.
    self.dynamicType.recursiveRemoveAnimationsOnView(self)
    
    if let superview = self.superview {
      self.center = CGPoint(x: superview.bounds.midX, y: self.center.y)
    }
  }
  
  private class func recursiveRemoveAnimationsOnView(view: UIView) {
    view.layer.removeAllAnimations()
    for subview in view.subviews as! [UIView] {
      self.recursiveRemoveAnimationsOnView(subview)
    }
  }
}
