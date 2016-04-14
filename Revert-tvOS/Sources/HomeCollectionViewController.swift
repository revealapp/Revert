//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit
 
final class HomeCollectionViewController: UICollectionViewController, SettableHomeCollectionGroup {
  var collectionGroup: String? {
    didSet {
      self.dataSource.filterGroups({
        if let groupTitle = $0.title, collectionTitle = self.collectionGroup {
          return groupTitle.localizedStandardContainsString(collectionTitle)
        } else {
          return false
        }
      })

      self.collectionView?.reloadData()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      collection: CollectableCollection<HomeItem>(items: .Home),
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.HomeCollection
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.dataSource = self.dataSource
    self.collectionView?.remembersLastFocusedIndexPath = true
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? NSIndexPath else {
        fatalError("`SettableHomeItem` requires `indexPath` to be sent as the sender.")
      }

      destinationViewController.item = self.dataSource[indexPath]
    }
  }

  // MARK: - Private
  private let dataSource: CollectionDataSource<HomeItem, HomeCollectionCell>
}
 
private extension HomeCollectionViewController {
  static func configureCell(cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.imageView.image = UIImage(named: item.iconName)
  }
}

// MARK:- UICollectionViewDelegate
extension HomeCollectionViewController {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let item = self.dataSource[indexPath]

    self.performSegueWithIdentifier(item.segueIdentifier, sender: indexPath)
  }
}

protocol SettableHomeCollectionGroup: class {
  var collectionGroup: String? { get set }
}
