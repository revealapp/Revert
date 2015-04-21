//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  
  @IBInspectable var resourceFilename: String? {
    didSet {
      if let resourceFilename = self.resourceFilename {
        let collection = CollectableCollection<MasterItem>(resourceFilename: resourceFilename)
        self.dataSource = CollectableTableViewDataSource(collection: collection, cellConfigurator: self.cellConfigurator)
        self.collection = collection
      } else {
        self.collection = nil
        self.dataSource = nil
      }
    }
  }
  
  private let cellConfigurator = MasterCellConfigurator()
  private var collection: CollectableCollection<MasterItem>?
  private var dataSource: CollectableTableViewDataSource?
  
  private func transitionToViewControllerForItem(item: MasterItem) {
    let destinationNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier(item.storyboardIdentifier) as! UINavigationController
    let destinationViewController = destinationNavigationController.topViewController

    if let destinationViewController = destinationViewController as? ControlsViewController {
      destinationViewController.resourceFilename = item.resourceFilename
    }
    
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      self.splitViewController!.viewControllers[1] = destinationNavigationController
    } else if item.isPush {
      self.navigationController!.pushViewController(destinationViewController, animated: true)
    } else {
      self.presentViewController(destinationNavigationController, animated: true, completion: nil)
    }
  }
  
  private func deselectSelectedRowIfNeeded() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
    self.tableView.registerNib(UINib(nibName: SB.Cell.Master, bundle: nil), forCellReuseIdentifier: SB.Cell.Master)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.deselectSelectedRowIfNeeded()
  }
}

// MARK: UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let collection = self.collection {
      self.transitionToViewControllerForItem(collection.itemAtIndexPath(indexPath))
    }
  }
}