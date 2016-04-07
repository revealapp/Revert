//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension UIAlertView {
  static func exampleAlertView() -> UIAlertView {
    return UIAlertView(
      title: NSLocalizedString("This is a UIAlertView", comment: "Alert title"),
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
      title: NSLocalizedString("This is a UIActionSheet", comment: "Alert title"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("Cancel", comment: "Alert Cancel button title"),
      destructiveButtonTitle: NSLocalizedString("Delete", comment: "Alert Delete button title"))
    return actionSheet
  }
}
