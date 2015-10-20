//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AlertViewController: RevertTableViewController {
  private var collection = CollectableCollection<Item>(items: .Alert)
  private var dataSource: AlertsDataSource
  private let cellConfigurator = AlertCellConfigurator()

  private enum Identifier: String {
    case AlertView = "alertview"
    case ActionSheet = "actionsheet"
    case AlertController = "alertcontroller"
    case ActionController = "actioncontroller"
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = AlertsDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    
    // Setup dynamic type notifications.
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    // Reload tableview to update the cell font sizes.
    self.tableView?.reloadData()
  }
}

// MARK: Presenters
extension AlertViewController {
  @available(iOS 8.0, *)
  private func displayAlertControllerForWithStyle(style: UIAlertControllerStyle, fromView: UIView) {
    let alertViewController = UIAlertController.exampleAlertControllerWithStyle(style)
    alertViewController.popoverPresentationController?.sourceView = fromView
    self.presentViewController(alertViewController, animated: true, completion: nil)
  }
  
  private func displayCorrespondingAlertForIdentifier(identifier: Identifier, fromView: UIView) {
    switch identifier {
    case .AlertView:
      UIAlertView.exampleAlertView().show()
    case .ActionSheet:
      UIActionSheet.exampleActionSheet().showInView(fromView)
    default:
      if #available(iOS 8.0, *) {
        let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .Alert : .ActionSheet
        self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
      }
    }
  }
}

// MARK: UITableViewDelegate
extension AlertViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)!
    let item = self.collection[indexPath]
    self.displayCorrespondingAlertForIdentifier(Identifier(rawValue: item.cellIdentifier)!, fromView: cell)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
