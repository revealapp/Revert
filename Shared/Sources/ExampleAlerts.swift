//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension UIAlertController {
  static func exampleAlertControllerWithStyle(style: UIAlertControllerStyle) -> UIAlertController {
    let alertViewController = UIAlertController(
      title: NSLocalizedString("This is a UIAlertController", comment: "Alert title"),
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

#if os(iOS)
  extension AlertViewController {
    static func showExampleAlertView() {
      UIAlertView.exampleAlertView().show()
    }

    static func showExampleActionsSheetInView(view : UIView) {
      UIActionSheet.exampleActionSheet().showInView(view)
    }
  }
#endif
