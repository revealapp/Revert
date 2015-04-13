//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  private let collection = CollectableCollection<MasterItem>(resourceFileName: "MasterItems")
  private let cellConfigurator = MasterCellConfigurator()
  
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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.deselectSelectedRowIfNeeded()
  }
}

// MARK: UITableViewDataSource

extension MasterViewController: UITableViewDataSource {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfGroups
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfRows
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.Master, forIndexPath: indexPath) as! MasterCell
    let item = self.collection.itemAtIndexPath(indexPath)

    self.cellConfigurator.configureCell(cell, withItem: item)
    return cell
  }
}

// MARK: UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection.itemAtIndexPath(indexPath)
    self.transitionToViewControllerForItem(item)
  }
}