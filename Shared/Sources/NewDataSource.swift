// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

/// The purpose of this class is to eventually replace the current custom data source class (`DataSource`).
/// The existing custom class is more complex and incompatible with models that extend `Decodable`.
final class NewDataSource<Section: SectionItem, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, Section.Item) -> Void

  // MARK: - Private Properties

  private var sections: [Section]
  private let cellIdentifier: String
  private let configureCell: CellConfigurator

  // MARK: - Init

  required init(sections: [Section], cellIdentifier: String, configureCell: @escaping CellConfigurator) {
    self.sections = sections
    self.cellIdentifier = cellIdentifier
    self.configureCell = configureCell

    super.init()
  }

  // MARK: - Public methods

  subscript(indexPath: IndexPath) -> Section.Item {
    return sections[indexPath.section].rows[indexPath.row]
  }

  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, self[indexPath])
    return cell
  }
}
