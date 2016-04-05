//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit
 
final class HomeCollectionViewController: UICollectionViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.HomeCollection
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.dataSource = self.dataSource
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if let destinationViewController = segue.destinationTopViewController as? SettableHomeItem {
      guard let indexPath = sender as? NSIndexPath else {
        fatalError("`SettableHomeItem` requres `indexPath` to be sent as the sender.")
      }

      destinationViewController.item = self.collection[indexPath]
    }
  }

  //MARK: - Private
  private var collection = CollectableCollection<HomeItem>(items: .HomeCollection)
  private var dataSource: CollectionDataSource<HomeItem, HomeCollectionCell>
}
 
private extension HomeCollectionViewController {
  static func configureCell(cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    
    // TODO: remove **the check** later on. This is just for testing purposes while we don't have images ready.
    if let iconImage = UIImage(named: item.iconName) {
      cell.imageView.image = iconImage
    } else {
      cell.imageView.image = UIImage(named: "icon_AlertView")
    }
  }
}

// MARK:- UICollectionViewDelegate
extension HomeCollectionViewController {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection[indexPath]

    self.performSegueWithIdentifier(item.segueIdentifier, sender: indexPath)
  }
}
