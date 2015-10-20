//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AlertsDataSource: NSObject, UITableViewDataSource {
  private let collection: CollectableCollection<Item>
  private let cellConfigurator: AlertCellConfigurator
  
  required init(collection: CollectableCollection<Item>, cellConfigurator: AlertCellConfigurator) {
    self.collection = collection
    self.cellConfigurator = cellConfigurator
    
    super.init()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfItems
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.Alert) as? BasicCell else {
      fatalError("Expecting to dequeue a `BasicCell` from the tableView")
    }

    let item = self.collection[indexPath]
    self.cellConfigurator.configureCell(cell, item: item)
    return cell
  }
}
