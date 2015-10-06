//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation
import SafariServices

@available(iOS 9.0, *)
final class SafariViewController: RevertViewController {
  
  @IBAction func buttonActionHandler() {
    let sfc = SFSafariViewController(URL: NSURL(string: "http://www.revealapp.com")!)
    sfc.delegate = self
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    presentViewController(sfc, animated: true, completion: nil)
  }
}

//MARK : SFSafariViewControllerDelegate
@available(iOS 9.0, *)
extension SafariViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(controller: SFSafariViewController) {
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  
}