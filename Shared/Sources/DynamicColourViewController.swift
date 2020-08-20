// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class DynamicColourViewController: RevertTableViewController {

  private let collection: [ColourSection] = RevertItems.coloursData

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

extension DynamicColourViewController {

  override func numberOfSections(in tableView: UITableView) -> Int {
      collection.count
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      collection[section].rows.count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      collection[section].title
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewControllerCell") as? DynamicColourCell else {
      fatalError("Unknown cellIdentifier or cell")
    }

    cell.setupCell(with: collection[indexPath.section].rows[indexPath.row])

    return cell
  }
}
