//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CountriesViewController: RevertTableViewController {
  private let collection = CollectableCollection<Country>(items: .CountriesCapitals)
  private let dataSource: DataSource<Country, BasicCell>
  private var refreshTimer: NSTimer?

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.TableViewController,
      titleForFooter: self.dynamicType.titleForFooter
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource

    #if os(iOS)
      self.setupRefreshControl()
    #endif
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

// MARK:- UITableViewDelegate
extension CountriesViewController {
  @available(iOS 9.0, *)
  override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    if let nextFocusedIndexPath = context.nextFocusedIndexPath {
      self.tableView.selectRowAtIndexPath(nextFocusedIndexPath, animated: true, scrollPosition: .None)
    }
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    if cell?.accessoryType == .Checkmark {
      cell?.accessoryType = .None
    } else {
      cell?.accessoryType = .Checkmark
    }

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let text = self.dataSource.tableView(tableView, titleForFooterInSection: section)
    return self.dynamicType.footerLabelWithText(text)
  }
}

private extension CountriesViewController {
  static func configureCell(cell: BasicCell, object: Country) {
    cell.accessoryType = .None

    cell.titleLabel.text = object.name
    cell.subtitleLabel.text = object.capital
  }

  static func titleForFooter(group: CollectableGroup<Country>) -> String? {
    let count = group.countOfItems
    return NSString(format: NSLocalizedString("%lu Countries", comment: "CountriesViewController footer format"), count) as String
  }
}

#if os(iOS)
  extension CountriesViewController {
    private func setupRefreshControl() {
      self.refreshControl = UIRefreshControl()
      self.refreshControl?.addTarget(self, action: #selector(self.tableViewPulledToRefresh(_:)), forControlEvents: .ValueChanged)
    }

    func tableViewPulledToRefresh(refreshControl: UIRefreshControl) {
      self.refreshTimer?.invalidate()

      // Simulating data loading, 10 secs to be sure that there's enough time to Reveal the view before it ends
      self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(self.didLoadDummyData(_:)), userInfo: nil, repeats: false)
    }

    func didLoadDummyData(timer: NSTimer) {
      self.refreshControl?.endRefreshing()
    }
  }
#endif
