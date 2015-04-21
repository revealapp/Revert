//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  @IBInspectable internal var resourceFilename: String? {
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
  
  private func deselectSelectedRowIfNeeded() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.resourceFilename != nil, "Resource file name should be set before viewDidLoad:")

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
    if let item = self.collection?.itemAtIndexPath(indexPath),
      cell = tableView.cellForRowAtIndexPath(indexPath) {
        self.performSegueWithIdentifier(item.segueIdentifier, sender: cell)
    }
  }
}