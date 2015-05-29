//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController {
  private let cellConfigurator = HomeCellConfigurator()
  private var collection = CollectableCollection<HomeItem>(resourceFilename: "HomeItems")
  private var dataSource: HomeDataSource
  private var currentDetailIndexPath: NSIndexPath?
  
  private func deselectSelectedRowIfNeeded() {
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      return
    }
    
    // Deselects the selected cell on phones to fix the selection state when interactively panning
    // from the edge of the screen.
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
      self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
    }
  }
  
  private var wasInitiallySelected = false
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = HomeDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    super.init(coder: aDecoder)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    self.tableView.registerNib(UINib(nibName: SB.Cell.Home, bundle: nil), forCellReuseIdentifier: SB.Cell.Home)
    
    // Setup dynamic type notifications.
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.deselectSelectedRowIfNeeded()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    // Sets the item object on the destination view controller required for a potential later transition to `InfoViewController`.
    if let destinationViewController = ((segue.destinationViewController as? UINavigationController)?.topViewController ?? segue.destinationViewController) as? SettableHomeItem,
      indexPath = sender as? NSIndexPath {
        destinationViewController.item = self.collection[indexPath]
    } else {
      fatalError("Transition to view controller that doesn't implement `SettableHomeItem` protocol")
    }
  }
  
  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    // Reload tableview to update the cell font sizes.
    self.tableView!.reloadData()
  }
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection[indexPath]
    
    // Only perform segue if the selected item isn't the one currently selected.
    if indexPath != self.currentDetailIndexPath {
      self.performSegueWithIdentifier(item.segueIdentifier, sender: indexPath)
      
      // The current detailed screen should only be saved for iPads as the splitview controller
      // behaves differently on phones.
      if UIDevice.currentDevice().userInterfaceIdiom == .Pad && item.isPush {
        self.currentDetailIndexPath = indexPath
      }
    }
  }
}