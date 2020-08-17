// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

/// The purpose of this class is to eventually replace the current custom data source class (`DataSource`).
/// The existing custom class is more complex and incompatible with models that extend `Decodable`.
final class NewDataSource<Model: Decodable, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias Models = [[Model]]
  typealias CellConfigurator = (Cell, _ object: Model) -> Void

  // MARK: - Private Properties

  private let data: Models
  private let cellIdentifier: String
  private let configureCell: CellConfigurator

  // MARK: - Init

  required init(collection: Models, cellIdentifier: String, configureCell: @escaping CellConfigurator) {
    self.data = collection
    self.cellIdentifier = cellIdentifier
    self.configureCell = configureCell

    super.init()
  }

  // MARK: - Public methods

  subscript(indexPath: IndexPath) -> Model {
    return data[indexPath.section][indexPath.row]
  }

  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, data[indexPath.section][indexPath.row])
    return cell
  }
}
