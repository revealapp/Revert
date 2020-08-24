//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class DataSource<Section: RevertSection, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Cell, Section.Item) -> Void
  typealias FooterTitleRetriever = ((Section) -> String?)?

  // MARK: - Private Properties

  private var sections: [Section]
  private let cellIdentifier: String
  private let configureCell: CellConfigurator
  private let titleForFooter: FooterTitleRetriever


  // MARK: - Init

  required init(sections: [Section], cellIdentifier: String, configureCell: @escaping CellConfigurator, titleForFooter: FooterTitleRetriever = nil) {
    self.sections = sections
    self.cellIdentifier = cellIdentifier
    self.configureCell = configureCell
    self.titleForFooter = titleForFooter

    super.init()
  }

  // MARK: - Public methods

  subscript(indexPath: IndexPath) -> Section.Item {
    return self.sections[indexPath.section].rows[indexPath.row]
  }

  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sections[section].rows.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell else {
      fatalError("Expecting to dequeue a `\(Cell.self)` from the tableView")
    }

    self.configureCell(cell, self[indexPath])
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.sections[section].title
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.titleForFooter?(self.sections[section])
  }
}
