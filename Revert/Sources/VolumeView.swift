//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import MediaPlayer
import UIKit

final class VolumeView: MPVolumeView {
  override func layoutSubviews() {
    super.layoutSubviews()

    // This removes the entrance animation of MPVolumeView on iOS8 whereby
    // the view animates from frame CGRectZero to final frame.
    type(of: self).recursiveRemoveAnimationsOnView(self)

    if let superview = self.superview {
      self.center = CGPoint(x: superview.bounds.midX, y: self.center.y)
    }
  }

  // MARK: Private

  private static func recursiveRemoveAnimationsOnView(_ view: UIView) {
    view.layer.removeAllAnimations()
    view.subviews.forEach { self.recursiveRemoveAnimationsOnView($0) }
  }
}
