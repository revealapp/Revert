//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ControlsDataSource: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (CollectionViewCell) -> Void
  fileprivate let collection: CollectableCollection<Item>

  required init(collection: CollectableCollection<Item>) {
    self.collection = collection

    super.init()
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.collection.countOfItems
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = self.collection[indexPath]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier, for: indexPath) as? CollectionViewCell else {
      fatalError("Expecting to dequeue a `CollectionViewCell` from the collectionView")
    }

    return cell
  }
}
