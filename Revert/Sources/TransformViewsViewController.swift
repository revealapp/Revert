//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class TransformViewsViewController: ViewController {
  @IBOutlet weak var translateView: UIView!
  @IBOutlet weak var rotateView: UIView!
  @IBOutlet weak var scaleView: UIView!
  @IBOutlet weak var scrollViewItemHeight: NSLayoutConstraint!
  
  private var wasAnimated = false

  private func animateViewsIfNecessary() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true
    
    UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
      self.translateView.transform = CGAffineTransformMakeTranslation(-20, 20)
      self.rotateView.transform = CGAffineTransformMakeRotation(CGFloat(15 * M_PI / 180))
      self.scaleView.transform = CGAffineTransformMakeScale(0.5, 0.5)
      }, completion: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateViewsIfNecessary()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let scrollViewItemHeight = floor(self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length) / 3
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, 150)
  }
}

