//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CollectableTableViewDataSource: NSObject, UITableViewDataSource {
  private let collection: CollectableCollection<MasterItem>
  private let cellConfigurator: MasterCellConfigurator
  
  required init(collection: CollectableCollection<MasterItem>, cellConfigurator: MasterCellConfigurator) {
    self.collection = collection
    self.cellConfigurator = cellConfigurator
    
    super.init()
  }
  
  internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfGroups
  }
  
  internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfRows
  }
  
  internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.Master, forIndexPath: indexPath) as! MasterCell
    let item = self.collection.itemAtIndexPath(indexPath)
    
    self.cellConfigurator.configureCell(cell, withItem: item)
    return cell
  }
}
