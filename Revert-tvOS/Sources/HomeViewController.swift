//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.registerNib(UINib(nibName: Storyboards.Cell.Home, bundle: nil), forCellReuseIdentifier: Storyboards.Cell.Home)    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if let destinationViewController = segue.destinationTopViewController as? SettableHomeCollectionGroup {
      guard let indexPath = sender as? NSIndexPath else {
        fatalError("`SettableHomeCollectionGroup` requires `indexPath` to be sent as the sender.")
      }

      guard let groupTitle = self.collection[indexPath.row].title else {
        fatalError("`SettableHomeCollectionGroup` requires a named group.")
      }

      destinationViewController.collectionGroup = groupTitle
    }
  }
  
  //MARK: - Private
  
  private let collection = CollectableCollection<HomeItem>(items: .Home)
}

extension HomeViewController {
  override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    guard let nextFocusedIndexPath = context.nextFocusedIndexPath where nextFocusedIndexPath != context.previouslyFocusedIndexPath else {
      // We don't want to perform unnecessary segues when moving back from the detail view.
      // This also helps the detail collection view to remember the last focused item.

      return
    }

    self.performSegueWithIdentifier(Storyboards.Segue.DetailsCollectionView, sender: nextFocusedIndexPath)

    self.tableView.selectRowAtIndexPath(nextFocusedIndexPath, animated: true, scrollPosition: .None)
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(Storyboards.Cell.Home) as? HomeCell else {
      fatalError("Expecting to dequeue a `\(HomeCell.self)` from the tableView")
    }

    cell.titleLabel.text = self.collection[indexPath.row].title
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let splitViewController = self.splitViewController as? RevertSplitViewController else {
      fatalError("tvOS `SplitViewController` should always be of type `RevertSplitViewController")
    }
    
    splitViewController.focusDetailView()
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    guard let cell = cell as? HomeCell else {
      fatalError("Cell should be of type `HomeCollectionCell`")
    }
    
    cell.accessoryType = .None
  }
}

private extension HomeViewController {
  static func configureCell(cell: HomeCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
  }
}
