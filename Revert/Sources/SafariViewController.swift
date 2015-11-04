//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation
import SafariServices

@available(iOS 9.0, *)
final class SafariViewController: RevertViewController {
  @IBAction func buttonActionHandler() {
    let safariViewController = SFSafariViewController(URL: NSBundle.mainBundle().revealWebsiteURL)
    safariViewController.delegate = self
    UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    presentViewController(safariViewController, animated: true, completion: nil)
  }
}

//MARK : SFSafariViewControllerDelegate
@available(iOS 9.0, *)
extension SafariViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(controller: SFSafariViewController) {
    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
}
