//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class SearchViewController: UICollectionViewController {

  required init?(coder aDecoder: NSCoder) {
    self.newDataSource = NewCollectionDataSource(
      sections: sections,
      configureCell: type(of: self).configureCell,
      cellIdentifier: CellIdentifiers.homeCollection
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.dataSource = self.newDataSource
    self.collectionView?.remembersLastFocusedIndexPath = true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? IndexPath else {
        fatalError("`SettableHomeItem` requires `indexPath` to be sent as the sender.")
      }

      destinationViewController.item = newDataSource[indexPath]
    }
  }

  // MARK: Private

  private let newDataSource: NewCollectionDataSource<HomeCollectionCell>
  private let sections: [HomeSectionItem] = RevertItems.home.newData()

  fileprivate var searchText: String? {
    didSet {
      guard searchText != oldValue else {
        // We don't want to keep reloading content if the search text has not changed.
        return
      }

      if let string = searchText, string.isEmpty == false {
        self.newDataSource.filter({
          $0.title.localizedStandardContains(string)
        })
      } else {
        self.newDataSource.clearFilter()
      }

      self.collectionView?.reloadData()
    }
  }
}

private extension SearchViewController {

  static func configureCell(_ cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.imageView.image = UIImage(named: item.iconName)
  }
}

// MARK: UICollectionViewDelegate

extension SearchViewController {

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = newDataSource[indexPath]

    self.performSegue(withIdentifier: item.segueIdentifier, sender: indexPath)
  }
}

extension SearchViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    self.searchText = searchController.searchBar.text
  }
}
