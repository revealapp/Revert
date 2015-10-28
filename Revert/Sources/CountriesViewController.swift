//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CountriesViewController: RevertTableViewController {
  private let collection = CollectableCollection<Country>(items: .CountriesCapitals)
  private let dataSource: DataSource<Country, BasicCell>
  private var refreshTimer: NSTimer?
  
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: SB.Cell.TableViewController,
      titleForFooter: self.dynamicType.titleForFooter
    )

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

  private static func footerLabelWithText(text: String?) -> UILabel {
    let label = UILabel()
    label.backgroundColor = UIColor.whiteColor()
    label.text = text
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
    label.textColor = UIColor.revertLightBlackColor()
    label.textAlignment = .Center
    return label
  }
}

// MARK : UITableViewDelegate
extension CountriesViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let text = self.dataSource.tableView(tableView, titleForFooterInSection: section)
    return self.dynamicType.footerLabelWithText(text)
  }
}

private extension CountriesViewController {
  static func configureCell(cell: BasicCell, object: Country) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.titleLabel.text = object.name

    cell.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    cell.subtitleLabel.text = object.capital
  }

  static func titleForFooter(group: CollectableGroup<Country>) -> String? {
    let count = group.countOfItems
    return NSString(format: NSLocalizedString("%lu Countries", comment: "CountriesViewController footer format"), count) as String
  }
}
