//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

extension UIViewController {
  
  internal func presentInfoViewControllerWithItem(item: MasterItem) {
    let infoNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier(SB.VC.Help) as! UINavigationController
    
    (infoNavigationController.topViewController as! InfoViewController).item = item

    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      let popover = UIPopoverController(contentViewController: infoNavigationController)
      popover.backgroundColor = UIColor.revertTintColor()
      popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem!, permittedArrowDirections: .Up, animated: true)
    } else {
      self.presentViewController(infoNavigationController, animated: true, completion: nil)
    }
  }
}