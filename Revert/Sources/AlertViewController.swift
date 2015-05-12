//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class AlertViewController: UITableViewController, SettableMasterItem {
  var item: MasterItem?
  
  private enum Sections: Int {
    case AlertView
    case AlertController
  }
  
  private enum Rows: Int {
    case AlertView
    case ActionSheet
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}

// MARK: Presenters

extension AlertViewController {
  private func displayAlertControllerForWithStyle(style: UIAlertControllerStyle, fromView: UIView) {
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
    
    alertViewController.popoverPresentationController?.sourceView = fromView
    self.presentViewController(alertViewController, animated: true, completion: nil)
  }
  
  private func displayAlertView() {
    UIAlertView(
      title: NSLocalizedString("alertviewcontroller.alertview.title", comment: "Alert title"),
      message: NSLocalizedString("alertviewcontroller.alert.message", comment: "Alert message"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      otherButtonTitles: NSLocalizedString("ok", comment: "Alert Ok button title"),
      NSLocalizedString("delete", comment: "Alert Delete button title")).show()
  }
  
  private func displayActionSheetFromView(fromView: UIView) {
    let actionSheet = UIActionSheet(
      title: NSLocalizedString("alertviewcontroller.actionsheet.title", comment: "Alert title"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("cancel", comment: "Alert Cancel button title"),
      destructiveButtonTitle: NSLocalizedString("delete", comment: "Alert Delete button title"))

    actionSheet.showInView(fromView)
  }
  
  private func displayCorrespondingAlertForSection(section: Sections, row: Rows, fromView: UIView) {
    switch section {
    case .AlertView where row == .AlertView:
      self.displayAlertView()
      break;
      
    case .AlertView where row == .ActionSheet:
      self.displayActionSheetFromView(fromView)
      break;
      
    default:
      self.displayAlertControllerForWithStyle(row == .AlertView ? .Alert : .ActionSheet, fromView: fromView)
    }
  }
}

// MARK: UITableViewDelegate

extension AlertViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)!
    self.displayCorrespondingAlertForSection(Sections(rawValue: indexPath.section)!, row: Rows(rawValue: indexPath.row)!, fromView: cell)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: UITableViewDataSource

extension AlertViewController: UITableViewDataSource {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return NSClassFromString("UIAlertController") != nil ? 2 : 1
  }
}

