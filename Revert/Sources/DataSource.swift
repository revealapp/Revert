//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

class DataSource<Object: Collectable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, object: Object) -> Void
  typealias CellIdenfitier = (Object) -> String

  private let collection: CollectableCollection<Object>
  private let configureCell: CellConfigurator
  private let identifyCellWithObject: CellIdenfitier

  required init(collection: CollectableCollection<Object>, configureCell: CellConfigurator, identifyCell: CellIdenfitier) {
    self.collection = collection
    self.configureCell = configureCell
    self.identifyCellWithObject = identifyCell

    super.init()
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfItems
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let object = self.collection[indexPath]
    let cellIdentifier = self.identifyCellWithObject(object)

    guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, object: object)
    return cell
  }
}
