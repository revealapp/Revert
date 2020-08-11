//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = NewDataSource(
      collection: collection,
      cellIdentifier: CellIdentifiers.home,
      configureCell: type(of: self).configureCell
    )

    super.init(coder: aDecoder)
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: UIViewController.showDetailTargetDidChangeNotification, object: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
    let homeNib = UINib(nibName: CellIdentifiers.home, bundle: nil)
    self.tableView.register(homeNib, forCellReuseIdentifier: CellIdentifiers.home)

    NotificationCenter.default.addObserver(self, selector: #selector(self.showDetailTargetDidChange(_:)), name: UIViewController.showDetailTargetDidChangeNotification, object: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.deselectSelectedRowIfNeeded()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    // Sets the item object on the destination view controller required for a potential later transition to `InfoViewController`.
    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? IndexPath else {
        fatalError("`SettableHomeItem` requires `indexPath` to be sent as the sender.")
      }
      destinationViewController.item = self.collection[indexPath.section][indexPath.row]
    }
  }

  @objc func showDetailTargetDidChange(_ notification: Notification) {
    // Updates the cell's accessoryType and selected background color when the split view collapses / expands
    self.tableView.visibleCells.forEach { cell in
      if let indexPath = self.tableView.indexPath(for: cell) {
        self.tableView(self.tableView, willDisplay: cell, forRowAt: indexPath)
      }
    }
  }

  // MARK: Private
  typealias HomeItems = [[HomeItem]]

  private let collection: HomeItems = RevertItems.home.newData()
  private let dataSource: NewDataSource<HomeItem, HomeCell>
  fileprivate var isSplitViewControllerCollapsed: Bool {
    return self.splitViewController?.isCollapsed ?? true
  }

  private func deselectSelectedRowIfNeeded() {
    // Deselects the selected cell if the split view controller is collapsed
    guard self.isSplitViewControllerCollapsed else {
      return
    }

    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRow(at: selectedIndexPath, animated: true)
    }
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = collection[indexPath.section][indexPath.row]
    self.performSegue(withIdentifier: item.segueIdentifier, sender: indexPath)
  }

  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? HomeCell else {
      fatalError("Cell should be of type `HomeCell`")
    }

    let item = collection[indexPath.section][indexPath.row]
    cell.accessoryType = self.isSplitViewControllerCollapsed && item.isPush ? .disclosureIndicator : .none
    cell.updateSelectedBackgroundColor(self.isSplitViewControllerCollapsed == false)
  }
}

private extension HomeViewController {

  static func configureCell(_ cell: HomeCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.iconImageView.image = UIImage(named: item.iconName)
  }
}
