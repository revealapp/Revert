//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CountriesViewController: RevertTableViewController {
  fileprivate let collection = CollectableCollection<Country>(items: .capitalCities)
  fileprivate let dataSource: DataSource<Country, BasicCell>
  fileprivate var refreshTimer: Timer?

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: type(of: self).configureCell,
      cellIdentifier: CellIdentifiers.tableViewController,
      titleForFooter: type(of: self).titleForFooter
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

  fileprivate static func footerLabelWithText(_ text: String?) -> UILabel {
    let label = UILabel()
    label.backgroundColor = UIColor.white
    label.text = text
    label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
    label.textColor = UIColor.revertLightBlackColor()
    label.textAlignment = .center
    return label
  }
}

// MARK: - UITableViewDelegate
extension CountriesViewController {

  @available(iOS 9.0, *)
  override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if let nextFocusedIndexPath = context.nextFocusedIndexPath {
      self.tableView.selectRow(at: nextFocusedIndexPath, animated: true, scrollPosition: .none)
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    if cell?.accessoryType == .checkmark {
      cell?.accessoryType = .none
    } else {
      cell?.accessoryType = .checkmark
    }

    tableView.deselectRow(at: indexPath, animated: true)
  }

  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let text = self.dataSource.tableView(tableView, titleForFooterInSection: section)
    return type(of: self).footerLabelWithText(text)
  }
}

private extension CountriesViewController {

  static func configureCell(_ cell: BasicCell, object: Country) {
    cell.accessoryType = .none

    cell.titleLabel.text = object.name
    cell.subtitleLabel.text = object.capital
  }

  static func titleForFooter(_ group: CollectableGroup<Country>) -> String? {
    let count = group.countOfItems
    return NSString(format: NSLocalizedString("%lu Countries", comment: "CountriesViewController footer format") as NSString, count) as String
  }
}

#if os(iOS)

  extension CountriesViewController {

    fileprivate func setupRefreshControl() {
      self.refreshControl = UIRefreshControl()
      self.refreshControl?.addTarget(self, action: #selector(self.tableViewPulledToRefresh(_:)), for: .valueChanged)
    }

    func tableViewPulledToRefresh(_ refreshControl: UIRefreshControl) {
      self.refreshTimer?.invalidate()

      // Simulating data loading, 10 secs to be sure that there's enough time to Reveal the view before it ends
      self.refreshTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.didLoadDummyData(_:)), userInfo: nil, repeats: false)
    }

    func didLoadDummyData(_ timer: Timer) {
      self.refreshControl?.endRefreshing()
    }
  }
#endif
