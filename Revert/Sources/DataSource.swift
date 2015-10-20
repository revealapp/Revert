//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

class DataSource<Object: Collectable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, object: Object) -> Void
  typealias CellIdenfitier = (Object) -> String
  typealias FooterTitleGetter = ((CollectableGroup<Object>) -> String?)?

  private let collection: CollectableCollection<Object>
  private let configureCell: CellConfigurator
  private let identifyCellWithObject: CellIdenfitier
  private let titleForFooter: FooterTitleGetter

  required init(collection: CollectableCollection<Object>, configureCell: CellConfigurator, identifyCell: CellIdenfitier, titleForFooter: FooterTitleGetter = nil) {
    self.collection = collection
    self.configureCell = configureCell
    self.identifyCellWithObject = identifyCell
    self.titleForFooter = titleForFooter

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

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.collection[section].title
  }

  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.titleForFooter?(self.collection[section])
  }

  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    let items = self.collection.items
      .map { $0.title }
      .flatMap { $0 }

    return items.count > 0 ? items : nil
  }
}
