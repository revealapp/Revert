//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionViewController: RevertCollectionViewController { }

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboards.Cell.CollectionViewController, for: indexPath)
    cell.contentView.backgroundColor = cell.isSelected ? UIColor.graySelectionColor() : UIColor.whitesmokeColor()
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.graySelectionColor()
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.whitesmokeColor()
  }
}
