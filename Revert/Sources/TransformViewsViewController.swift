//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class TransformViewsViewController: RevertViewController {
  @IBOutlet private weak var translateView: UIView!
  @IBOutlet private weak var rotateView: UIView!
  @IBOutlet private weak var scaleView: UIView!
  @IBOutlet private weak var scrollViewItemHeight: NSLayoutConstraint!
  
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
  
  private static let minimumItemHeight: CGFloat = 150
  private static let numberOfItems = 3
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    // Update the scrollview' subview's height to match the screen height with a minimum value
    let totalAvailableHeight = self.view.bounds.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    let scrollViewItemHeight = floor(totalAvailableHeight / CGFloat(self.dynamicType.numberOfItems))
    self.scrollViewItemHeight.constant = max(scrollViewItemHeight, self.dynamicType.minimumItemHeight)
  }
}
