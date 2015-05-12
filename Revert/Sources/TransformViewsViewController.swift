//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class TransformViewsViewController: UIViewController, SettableMasterItem {
  
  @IBOutlet weak var translateView: UIView!
  @IBOutlet weak var rotateView: UIView!
  @IBOutlet weak var scaleView: UIView!
  
  private var wasAnimated = false
  var item: MasterItem?
  
  private func animateViewsIfNecessary() {
    // Only perform this action once
    if self.wasAnimated {
      return
    }
    self.wasAnimated = true
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
      self.translateView.transform = CGAffineTransformMakeTranslation(-20.0, 20.0)
      self.rotateView.transform = CGAffineTransformMakeRotation(CGFloat(15.0 * M_PI / 180.0))
      self.scaleView.transform = CGAffineTransformMakeScale(0.5, 0.5)
      }, completion: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateViewsIfNecessary()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}
