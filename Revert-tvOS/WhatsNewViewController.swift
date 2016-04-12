//
//Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class WhatsNewViewController: UIViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      collection: CollectableCollection<HomeItem>(items: .WhatsNew),
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.HomeCollection
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.dataSource = self.dataSource
    self.collectionView?.delegate = self
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

  //MARK: Private

  private let dataSource: CollectionDataSource<HomeItem, HomeCollectionCell>

  @IBOutlet private var collectionView: UICollectionView!
}

private extension WhatsNewViewController {
  static func configureCell(cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title

    // TODO: remove **the check** later on. This is just for testing purposes while we don't have images ready.
    if let iconImage = UIImage(named: item.iconName) {
      cell.imageView.image = iconImage
    } else {
      cell.imageView.image = UIImage(named: "orange")
    }
  }
}

// MARK:- UICollectionViewDelegate

extension WhatsNewViewController: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let item = self.dataSource[indexPath]

    self.performSegueWithIdentifier(item.segueIdentifier, sender: indexPath)
  }
}
