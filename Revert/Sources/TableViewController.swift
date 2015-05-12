//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class TableViewController: UITableViewController, SettableMasterItem {
  private let collection = CollectableCollection<Country>(resourceFilename: "CountriesCapitals")
  private let cellConfigurator = CountryCellConfigurator()
  private let dataSource: CountryDataSource
  private var refreshTimer: NSTimer?
  var item: MasterItem?
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = CountryDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
    
    self.tableView.dataSource = self.dataSource
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl!.addTarget(self, action: "tableViewPulledToRefresh:", forControlEvents: .ValueChanged)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  func tableViewPulledToRefresh(refreshControl: UIRefreshControl) {
    self.refreshTimer?.invalidate()

    // Simulating data loading, 10 secs to be sure that there's enough time to Reveal the view before it ends
    self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "didLoadDummyData:", userInfo: nil, repeats: false)
  }
  
  func didLoadDummyData(timer: NSTimer) {
    self.refreshControl!.endRefreshing()
  }
  
  func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
    self.tableView?.reloadData()
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}

// MARK : UITableViewDelegate

extension TableViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel()
    
    label.backgroundColor = UIColor.revertCountrySectionFooterColor()
    label.text = self.dataSource.tableView(tableView, titleForFooterInSection: section)
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
    label.textAlignment = .Center
    return label
  }
}
