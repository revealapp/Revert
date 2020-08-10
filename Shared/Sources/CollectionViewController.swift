//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionViewController: RevertCollectionViewController {}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionViewController, for: indexPath)
    cell.contentView.backgroundColor = cell.isSelected ? #colorLiteral(red: 0.8429999948, green: 0.8429999948, blue: 0.8429999948, alpha: 1) : #colorLiteral(red: 0.996, green: 0.996, blue: 0.996, alpha: 1)
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = #colorLiteral(red: 0.8429999948, green: 0.8429999948, blue: 0.8429999948, alpha: 1)
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = #colorLiteral(red: 0.996, green: 0.996, blue: 0.996, alpha: 1)
  }
}
