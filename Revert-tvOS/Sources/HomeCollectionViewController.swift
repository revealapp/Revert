//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeCollectionViewController: UICollectionViewController, GroupFilterable {
  var collectionGroup: String? {
    didSet {
      self.dataSource.filterGroups({
        if let collectionTitle = self.collectionGroup, let groupTitle = $0.title {
          return groupTitle.localizedStandardContains(collectionTitle)
        } else {
          return false
        }
      })

      self.collectionView?.reloadData()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      sections: RevertItems.home.newData(),
      configureCell: Self.configureCell,
      cellIdentifier: CellIdentifiers.homeCollection)

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.dataSource = self.dataSource
    self.collectionView?.remembersLastFocusedIndexPath = true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? IndexPath else {
        fatalError("`SettableHomeItem` requires `indexPath` to be sent as the sender.")
      }

      destinationViewController.item = dataSource[indexPath]
    }
  }

  // MARK: - Private
  private let dataSource: CollectionDataSource<HomeSection, HomeCollectionCell>
}

private extension HomeCollectionViewController {

  static func configureCell(_ cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.imageView.image = UIImage(named: item.iconName)
  }
}

// MARK: - UICollectionViewDelegate
extension HomeCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = self.dataSource[indexPath]

    self.performSegue(withIdentifier: item.segueIdentifier, sender: indexPath)
  }
}

protocol GroupFilterable: class {
  var collectionGroup: String? { get set }
}
