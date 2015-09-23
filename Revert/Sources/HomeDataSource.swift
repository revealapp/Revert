//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HomeDataSource: NSObject, UITableViewDataSource {
  private let collection: CollectableCollection<HomeItem>
  private let cellConfigurator: HomeCellConfigurator
  
  required init(collection: CollectableCollection<HomeItem>, cellConfigurator: HomeCellConfigurator) {
    self.collection = collection
    self.cellConfigurator = cellConfigurator
    
    super.init()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfGroups
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfRows
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.Home, forIndexPath: indexPath) as? HomeCell else {
      fatalError("Expecting to dequeue a HomeCell from the UITableView")
    }

    let item = self.collection[indexPath]
    self.cellConfigurator.configureCell(cell, withItem: item)
    return cell
  }
}
