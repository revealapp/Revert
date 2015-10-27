//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

class DataSource<Object: Collectable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, object: Object) -> Void
  typealias FooterTitleRetriever = ((CollectableGroup<Object>) -> String?)?

  private let collection: CollectableCollection<Object>
  private let configureCell: CellConfigurator
  private let cellIdentifier: String
  private let titleForFooter: FooterTitleRetriever

  required init(collection: CollectableCollection<Object>, configureCell: CellConfigurator, cellIdentifier: String, titleForFooter: FooterTitleRetriever = nil) {
    self.collection = collection
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier
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
    guard let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    let object = self.collection[indexPath]
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
