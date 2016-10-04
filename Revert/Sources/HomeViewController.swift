//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: type(of: self).configureCell,
      cellIdentifier: Storyboards.Cell.Home
    )

    super.init(coder: aDecoder)
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIViewControllerShowDetailTargetDidChange, object: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
    self.tableView.register(UINib(nibName: Storyboards.Cell.Home, bundle: nil), forCellReuseIdentifier: Storyboards.Cell.Home)

    NotificationCenter.default.addObserver(self, selector: #selector(self.showDetailTargetDidChange(_:)), name: NSNotification.Name.UIViewControllerShowDetailTargetDidChange, object: nil)
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
      destinationViewController.item = self.collection[indexPath]
    }
  }

  func showDetailTargetDidChange(_ notification: Notification) {
    // Updates the cell's accessoryType and selected background color when the split view collapses / expands
    self.tableView.visibleCells.forEach { cell in
      if let indexPath = self.tableView.indexPath(for: cell) {
        self.tableView(self.tableView, willDisplay: cell, forRowAt: indexPath)
      }
    }
  }

  // MARK: Private

  fileprivate var collection = CollectableCollection<HomeItem>(items: .Home)
  fileprivate var dataSource: DataSource<HomeItem, HomeCell>
  fileprivate var isSplitViewControllerCollapsed: Bool {
    return self.splitViewController?.isCollapsed ?? true
  }

  fileprivate func deselectSelectedRowIfNeeded() {
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
    let item = self.collection[indexPath]
    self.performSegue(withIdentifier: item.segueIdentifier, sender: indexPath)
  }

  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? HomeCell else {
      fatalError("Cell should be of type `HomeCell`")
    }

    let item = self.collection[indexPath]
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
