//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AlertViewController: UITableViewController {
  
  private enum Sections: Int {
    case AlertView
    case AlertController
  }
  
  private enum Rows: Int {
    case AlertView
    case ActionSheet
  }
  
  private func displayAlertControllerForWithStyle(style: UIAlertControllerStyle) {
    let alertViewController = UIAlertController(
      title: NSLocalizedString("alertviewcontroller.alert.title", comment: "Alert title"),
      message: NSLocalizedString("alertviewcontroller.alert.message", comment: "Alert message"),
      preferredStyle: style
    )
    
    alertViewController.view.tintColor = UIColor.revertGreenColor()
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
    self.presentViewController(alertViewController, animated: true, completion: nil)
  }
  
  private func displayAlertView() {
    UIAlertView(
      title: NSLocalizedString("alertviewcontroller.alert.title", comment: "Alert title"),
      message: NSLocalizedString("alertviewcontroller.alert.message", comment: "Alert message"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      otherButtonTitles: NSLocalizedString("ok", comment: "Alert Ok button title"),
      NSLocalizedString("delete", comment: "Alert Delete button title")).show()
  }
  
  private func displayActionSheet() {
    UIActionSheet(
      title: NSLocalizedString("alertviewcontroller.alert.title", comment: "Alert title"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      destructiveButtonTitle: NSLocalizedString("delete", comment: "Alert Delete button title")).showInView(self.view)
  }
  
  private func displayCorrespondingAlertForSection(section: Sections, row: Rows) {
    switch section {

    case .AlertView where row == .AlertView:
      self.displayAlertView()
      break;
      
    case .AlertView where row == .ActionSheet:
      self.displayActionSheet()
      break;

    default:
      self.displayAlertControllerForWithStyle(row == .AlertView ? .Alert : .ActionSheet)
    }
  }
}

// MARK: UITableViewDelegate

extension AlertViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.displayCorrespondingAlertForSection(Sections(rawValue: indexPath.section)!, row: Rows(rawValue: indexPath.row)!)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: UITableViewDataSource

extension AlertViewController: UITableViewDataSource {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return NSClassFromString("UIAlertController") != nil ? 2 : 1
  }
}

