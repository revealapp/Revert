//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self

    let cellNib = UINib(nibName: CellIdentifiers.home, bundle: nil)
    self.tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.home)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? GroupFilterable {
      guard let indexPath = sender as? IndexPath else {
        fatalError("`GroupFilterable` requires `indexPath` to be sent as the sender.")
      }

      destinationViewController.collectionGroup = collection[indexPath.row].title
    }
  }

  // MARK: - Private
  private let collection: [HomeSectionItem] = RevertItems.home.newData()
}

extension HomeViewController {

  override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    guard
      let nextFocusedIndexPath = context.nextFocusedIndexPath,
      nextFocusedIndexPath != context.previouslyFocusedIndexPath
      else {
      // We don't want to perform unnecessary segues when moving back from the detail view.
      // This also helps the detail collection view to remember the last focused item.

      return
    }

    self.performSegue(withIdentifier: SegueIdentifiers.detailsCollectionView, sender: nextFocusedIndexPath)

    self.tableView.selectRow(at: nextFocusedIndexPath, animated: true, scrollPosition: .none)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    collection.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.home) as? HomeCell else {
      fatalError("Expecting to dequeue a `\(HomeCell.self)` from the tableView")
    }

    cell.titleLabel.text = collection[indexPath.row].title
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let splitViewController = self.splitViewController as? RevertSplitViewController else {
      fatalError("tvOS `SplitViewController` should always be of type `RevertSplitViewController")
    }

    splitViewController.focusDetailView()
  }

  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? HomeCell else {
      fatalError("Cell should be of type `HomeCollectionCell`")
    }

    cell.accessoryType = .none
  }
}

private extension HomeViewController {

  static func configureCell(_ cell: HomeCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
  }
}
