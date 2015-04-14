//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  private let collection = CollectableCollection<MasterItem>(resourceFileName: "MasterItems")
  private let cellConfigurator = MasterCellConfigurator()
  private let dataSource: CollectableTableViewDataSource
  
  private func transitionToViewControllerForItem(item: MasterItem) {
    let destinationViewController = self.storyboard!.instantiateViewControllerWithIdentifier(item.storyboardIdentifier) as! UINavigationController
    
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      self.splitViewController!.viewControllers[1] = destinationViewController
    } else if item.isPush {
      self.navigationController!.pushViewController(destinationViewController.topViewController, animated: true)
    } else {
      self.presentViewController(destinationViewController, animated: true, completion: nil)
    }
  }
  
  private func deselectSelectedRowIfNeeded() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = CollectableTableViewDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.deselectSelectedRowIfNeeded()
  }
}

// MARK: UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection.itemAtIndexPath(indexPath)
    self.transitionToViewControllerForItem(item)
  }
}