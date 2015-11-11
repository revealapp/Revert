//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeViewController: UITableViewController {
  private var collection = CollectableCollection<HomeItem>(items: .Home)
  private var dataSource: DataSource<HomeItem, HomeCell>
  private var isSplitViewControllerCollapsed: Bool {
    // If self.splitViewController is nil then we're on iOS7 on phone, i.e equivalent to collapsed mode
    return self.splitViewController?.backwardCompatibleCollapsed ?? true
  }

  private func deselectSelectedRowIfNeeded() {
    // Deselects the selected cell if the split view controller is collapsed
    guard self.isSplitViewControllerCollapsed else {
      return
    }

    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }

  private var wasInitiallySelected = false

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.Home
    )

    super.init(coder: aDecoder)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
    self.tableView.registerNib(UINib(nibName: Storyboards.Cell.Home, bundle: nil), forCellReuseIdentifier: Storyboards.Cell.Home)

    if #available (iOS 8.0, *) {
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "showDetailTargetDidChange:", name: UIViewControllerShowDetailTargetDidChangeNotification, object: nil)
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.deselectSelectedRowIfNeeded()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    // Sets the item object on the destination view controller required for a potential later transition to `InfoViewController`.
    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? NSIndexPath else {
        fatalError("`SettableHomeItem` requires `indexPath` to be sent as the sender.")
      }
      destinationViewController.item = self.collection[indexPath]
    }
  }

  func showDetailTargetDidChange(notification: NSNotification) {
    // Updates the cell's accessoryType and selected background color when the split view collapses / expands
    self.tableView.visibleCells.forEach { cell in
      if let indexPath = self.tableView.indexPathForCell(cell) {
        self.tableView(self.tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
      }
    }
  }
}

// MARK: UITableViewDelegate
extension HomeViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection[indexPath]
    self.performSegueWithIdentifier(item.segueIdentifier, sender: indexPath)
  }

  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    guard let cell = cell as? HomeCell else {
      fatalError("Cell should be of type `HomeCell`")
    }

    let item = self.collection[indexPath]
    cell.accessoryType = self.isSplitViewControllerCollapsed && item.isPush ? .DisclosureIndicator : .None
    cell.updateSelectedBackgroundColor(isBlue: self.isSplitViewControllerCollapsed == false)
  }
}

private extension HomeViewController {
  static func configureCell(cell: HomeCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.iconImageView.image = UIImage(named: item.iconName)
  }
}
