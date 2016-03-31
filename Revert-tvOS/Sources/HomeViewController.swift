//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
    collection: self.collection,
    configureCell: self.dynamicType.configureCell,
    cellIdentifier: Storyboards.Cell.Home
    )
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    self.tableView.registerNib(UINib(nibName: Storyboards.Cell.Home, bundle: nil), forCellReuseIdentifier: Storyboards.Cell.Home)    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? NSIndexPath else {
        fatalError("`SettableHomeItem` requres `indexPath` to be sent as the sender.")
      }
      
      destinationViewController.item = self.collection[indexPath]
    }
  }
  
  //MARK: - Private
  
  private var collection = CollectableCollection<HomeItem>(items: .Home)
  private var dataSource: DataSource<HomeItem, HomeCell>

}

extension HomeViewController {
  override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    if let nextFocusedIndexPath = context.nextFocusedIndexPath {
      let item = self.collection[nextFocusedIndexPath]
      self.performSegueWithIdentifier(item.segueIdentifier, sender: nextFocusedIndexPath)
      
      self.tableView.selectRowAtIndexPath(nextFocusedIndexPath, animated: true, scrollPosition: .None)
    }
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
