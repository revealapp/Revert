//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class DataSource<Object: Collectable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, _ object: Object) -> Void
  typealias FooterTitleRetriever = ((CollectableGroup<Object>) -> String?)?

  required init(collection: CollectableCollection<Object>, configureCell: @escaping CellConfigurator, cellIdentifier: String, titleForFooter: FooterTitleRetriever = nil) {
    self.unfilteredCollection = collection
    self.collection = collection
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier
    self.titleForFooter = titleForFooter

    super.init()
  }

  // MARK: UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.collection.countOfItems
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, self.collection[indexPath])
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.collection[section].title
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.titleForFooter?(self.collection[section])
  }

  #if os(iOS)

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
      let items = self.collection.items
        .map { $0.title }
        .flatMap { $0 }

      return items.count > 0 ? items : nil
    }
  #endif

  subscript(indexPath: IndexPath) -> Object {
    return self.collection[indexPath]
  }

  func clearFilter() {
    self.collection = self.unfilteredCollection
  }

  func filter(_ filterClosure: ((Object) -> Bool)) {
    self.collection = self.unfilteredCollection.filteredCollectableCollection(filterClosure)
  }

  // MARK: Private

  private let unfilteredCollection: CollectableCollection<Object>
  private var collection: CollectableCollection<Object>
  private let configureCell: CellConfigurator
  private let cellIdentifier: String
  private let titleForFooter: FooterTitleRetriever
}
