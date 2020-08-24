//
// Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class WhatsNewViewController: UIViewController {

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      sections: self.sections,
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

      destinationViewController.item = self.dataSource[indexPath]
    }
  }

  // MARK: Private

  private let dataSource: CollectionDataSource<HomeSection, HomeCollectionCell>
  private let sections: [HomeSection] = RevertItems.whatsNew.data()

  @IBOutlet private var collectionView: UICollectionView!
}

private extension WhatsNewViewController {

  static func configureCell(_ cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.imageView.image = UIImage(named: item.iconName)
  }
}

// MARK: - UICollectionViewDelegate

extension WhatsNewViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = self.dataSource[indexPath]

    self.performSegue(withIdentifier: item.segueIdentifier, sender: indexPath)
  }
}
