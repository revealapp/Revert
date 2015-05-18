//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AlertViewController: RevertTableViewController {
  private var collection = CollectableCollection<Item>(resourceFilename: "AlertItems")
  private var dataSource: AlertsDataSource
  private let cellConfigurator = AlertCellConfigurator()

  private enum Identifier: String {
    case AlertView = "alertview"
    case ActionSheet = "actionsheet"
    case AlertController = "alertcontroller"
    case ActionController = "actioncontroller"
  }
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = AlertsDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    self.tableView?.reloadData()
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
  
  private func displayCorrespondingAlertForIdentifier(identifier: Identifier, fromView: UIView) {
    switch identifier {
    case .AlertView:
      self.displayAlertView()
      break;
      
    case .ActionSheet:
      self.displayActionSheetFromView(fromView)
      break;
      
    default:
      self.displayAlertControllerForWithStyle(identifier == .AlertController ? .Alert : .ActionSheet, fromView: fromView)
    }
  }
}

// MARK: UITableViewDelegate
extension AlertViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)!
    let item = self.collection.itemAtIndexPath(indexPath)
    self.displayCorrespondingAlertForIdentifier(Identifier(rawValue: item.cellIdentifier)!, fromView: cell)
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
