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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewControllerCell") else {
      fatalError("Unknown cellIdentifier or cell")
    }

    let section = collection[indexPath.section]
    let row = section.rows[indexPath.row]

    if #available(iOS 10.0, *) {
      let imageSize = CGSize(width: 50, height: 50)
      cell.imageView?.image = UIGraphicsImageRenderer(size: imageSize)
        .image { rendererContext in
          row.color.setFill()
          rendererContext.fill(CGRect(origin: .zero, size: imageSize))
      }
    }

    cell.imageView?.clipsToBounds = true
    cell.imageView?.layer.cornerRadius = 10

    cell.detailTextLabel?.attributedText = row.detailText
    cell.detailTextLabel?.textColor = .systemGray

    cell.textLabel?.text = row.name

    return cell
  }
}
