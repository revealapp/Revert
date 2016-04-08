//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class DataSource<Object: Collectable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, object: Object) -> Void
  typealias FooterTitleRetriever = ((CollectableGroup<Object>) -> String?)?

  required init(collection: CollectableCollection<Object>, configureCell: CellConfigurator, cellIdentifier: String, titleForFooter: FooterTitleRetriever = nil) {
    self.collection = collection
    self.filteredCollection = collection
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier
    self.titleForFooter = titleForFooter

    super.init()
  }

  // MARK: UITableViewDataSource

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.filteredCollection.countOfItems
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.filteredCollection[section].countOfItems
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, object: self.filteredCollection[indexPath])
    return cell
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.filteredCollection[section].title
  }

  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.titleForFooter?(self.filteredCollection[section])
  }

  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    let items = self.filteredCollection.items
      .map { $0.title }
      .flatMap { $0 }

    return items.count > 0 ? items : nil
  }

  func filter(filterClosure: ((Object) -> Bool)?) {
    self.filteredCollection = self.collection.filteredCollectableCollection(filterClosure)
  }

  // MARK: Private

  private let collection: CollectableCollection<Object>
  private var filteredCollection: CollectableCollection<Object>
  private let configureCell: CellConfigurator
  private let cellIdentifier: String
  private let titleForFooter: FooterTitleRetriever
}
