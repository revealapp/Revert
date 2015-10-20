//
//  ExampleAlerts.swift
//

import Foundation

@available(iOS 8.0, *)
extension UIAlertController {
  static func exampleAlertControllerWithStyle(style: UIAlertControllerStyle) -> UIAlertController {
    let alertViewController = UIAlertController(
      title: NSLocalizedString("alertviewcontroller.alert.title", comment: "Alert title"),
      message: NSLocalizedString("alertviewcontroller.alert.message", comment: "Alert message"),
      preferredStyle: style
    )

    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("ok", comment: "Alert Ok button title"),
      style: .Default,
      handler: nil)
    )
    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      style: .Cancel,
      handler: nil)
    )
    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("delete", comment: "Alert Delete button title"),
      style: .Destructive,
      handler: nil)
    )
    return alertViewController
  }
}

extension UIAlertView {
  static func exampleAlertView() -> UIAlertView {
    return UIAlertView(
      title: NSLocalizedString("alertviewcontroller.alertview.title", comment: "Alert title"),
      message: NSLocalizedString("alertviewcontroller.alert.message", comment: "Alert message"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      otherButtonTitles: NSLocalizedString("ok", comment: "Alert Ok button title"),
      NSLocalizedString("delete", comment: "Alert Delete button title"))
  }
}

extension UIActionSheet {
  static func exampleActionSheet() -> UIActionSheet {
    let actionSheet = UIActionSheet(
      title: NSLocalizedString("alertviewcontroller.actionsheet.title", comment: "Alert title"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      destructiveButtonTitle: NSLocalizedString("delete", comment: "Alert Delete button title"))
    return actionSheet
  }
}
