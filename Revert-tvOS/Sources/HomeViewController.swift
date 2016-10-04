//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: Storyboards.Cell.Home, bundle: nil), forCellReuseIdentifier: Storyboards.Cell.Home)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? GroupFilterable {
      guard let indexPath = sender as? IndexPath else {
        fatalError("`GroupFilterable` requires `indexPath` to be sent as the sender.")
      }

      guard let groupTitle = self.collection[indexPath.row].title else {
        fatalError("`GroupFilterable` requires a named group.")
      }

      destinationViewController.collectionGroup = groupTitle
    }
  }

  //MARK: - Private

  fileprivate let collection = CollectableCollection<HomeItem>(items: .Home)
}

extension HomeViewController {
  override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    guard let nextFocusedIndexPath = context.nextFocusedIndexPath, nextFocusedIndexPath != context.previouslyFocusedIndexPath else {
      // We don't want to perform unnecessary segues when moving back from the detail view.
      // This also helps the detail collection view to remember the last focused item.

      return
    }

    self.performSegue(withIdentifier: Storyboards.Segue.DetailsCollectionView, sender: nextFocusedIndexPath)

    self.tableView.selectRow(at: nextFocusedIndexPath, animated: true, scrollPosition: .none)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Storyboards.Cell.Home) as? HomeCell else {
      fatalError("Expecting to dequeue a `\(HomeCell.self)` from the tableView")
    }

    cell.titleLabel.text = self.collection[indexPath.row].title
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
