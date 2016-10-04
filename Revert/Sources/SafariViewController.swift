//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation
import SafariServices

@available(iOS 9.0, *)
final class SafariViewController: RevertViewController {

  @IBAction fileprivate func showSafariViewController(_ sender: UIButton) {
    let safariViewController = SFSafariViewController(url: Bundle.main.revealWebsiteURL)
    safariViewController.delegate = self
    UIApplication.shared.setStatusBarStyle(.default, animated: true)
    present(safariViewController, animated: true, completion: nil)
  }
}

// MARK: - SFSafariViewControllerDelegate
@available(iOS 9.0, *)
extension SafariViewController: SFSafariViewControllerDelegate {

  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    controller.dismiss(animated: true, completion: nil)
  }
}
