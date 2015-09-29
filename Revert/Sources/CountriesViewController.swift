//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CountriesViewController: RevertTableViewController {
  private let collection = CollectableCollection<Country>(items: .CountriesCapitals)
  private let cellConfigurator = CountryCellConfigurator()
  private let dataSource: CountriesDataSource
  private var refreshTimer: NSTimer?
  
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CountriesDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl!.addTarget(self, action: "tableViewPulledToRefresh:", forControlEvents: .ValueChanged)
    
    // Setup dynamic type notifications.
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  func tableViewPulledToRefresh(refreshControl: UIRefreshControl) {
    self.refreshTimer?.invalidate()

    // Simulating data loading, 10 secs to be sure that there's enough time to Reveal the view before it ends
    self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "didLoadDummyData:", userInfo: nil, repeats: false)
  }
  
  func didLoadDummyData(timer: NSTimer) {
    self.refreshControl?.endRefreshing()
  }
  
  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    // Reload tableview to update the cell font sizes.
    self.tableView?.reloadData()
  }
}

// MARK : UITableViewDelegate
extension CountriesViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel()
    
    label.backgroundColor = UIColor.whiteColor()
    label.text = self.dataSource.tableView(tableView, titleForFooterInSection: section)
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
    label.textColor = UIColor.revertLightBlackColor()
    label.textAlignment = .Center
    return label
  }
}
