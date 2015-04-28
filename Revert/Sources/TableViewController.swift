//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class TableViewController: UITableViewController {
  private let collection = CollectableCollection<Country>(resourceFilename: "CountriesCapitals")
  private let cellConfigurator = CountryCellConfigurator()
  private let dataSource: CountryDataSource
  private var refreshTimer: NSTimer?
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = CountryDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl!.addTarget(self, action: "tableViewPulledToRefresh:", forControlEvents: .ValueChanged)
  }
  
  func tableViewPulledToRefresh(refreshControl: UIRefreshControl) {
    self.refreshTimer?.invalidate()

    // Simulating data loading, 10 secs to be sure that there's enough time to Reveal the view before it ends
    self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "didLoadDummyData:", userInfo: nil, repeats: false)
  }
  
  func didLoadDummyData(timer: NSTimer) {
    self.refreshControl!.endRefreshing()
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
    label.font = UIFont.systemFontOfSize(12.0)
    label.textAlignment = .Center
    return label
  }
}
