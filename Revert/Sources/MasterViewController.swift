//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  private let cellConfigurator = MasterCellConfigurator()
  private var collection = CollectableCollection<MasterItem>(resourceFilename: "MasterItems")
  private var dataSource: CollectableTableViewDataSource
  
  private func deselectSelectedRowIfNeeded() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
  
  private var wasInitiallySelected = false
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = CollectableTableViewDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    super.init(coder: aDecoder)
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
    let item = self.collection.itemAtIndexPath(indexPath)
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      self.performSegueWithIdentifier(item.segueIdentifier, sender: cell)
    }
  }
}