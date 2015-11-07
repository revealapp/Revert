//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

@available(iOS 8.0, *)
extension UIAlertController {
  static func exampleAlertControllerWithStyle(style: UIAlertControllerStyle) -> UIAlertController {
    let alertViewController = UIAlertController(
      title: NSLocalizedString("This is an UIAlertController", comment: "Alert title"),
      message: NSLocalizedString("How are you feeling today?", comment: "Alert message"),
      preferredStyle: style
    )

    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("Ok", comment: "Alert Ok button title"),
      style: .Default,
      handler: nil)
    )
    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("Cancel", comment: "Alert Cancel button title"),
      style: .Cancel,
      handler: nil)
    )
    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("Delete", comment: "Alert Delete button title"),
      style: .Destructive,
      handler: nil)
    )
    return alertViewController
  }
}

extension UIAlertView {
  static func exampleAlertView() -> UIAlertView {
    return UIAlertView(
      title: NSLocalizedString("This is an UIAlertView", comment: "Alert title"),
      message: NSLocalizedString("How are you feeling today?", comment: "Alert message"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("Cancel", comment: "Alert Cancel button title"),
      otherButtonTitles: NSLocalizedString("Ok", comment: "Alert Ok button title"),
      NSLocalizedString("Delete", comment: "Alert Delete button title"))
  }
}

extension UIActionSheet {
  static func exampleActionSheet() -> UIActionSheet {
    let actionSheet = UIActionSheet(
      title: NSLocalizedString("This is an UIActionSheet", comment: "Alert title"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("Cancel", comment: "Alert Cancel button title"),
      destructiveButtonTitle: NSLocalizedString("Delete", comment: "Alert Delete button title"))
    return actionSheet
  }
}
