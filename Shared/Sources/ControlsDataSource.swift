//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class ControlsDataSource: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (CollectionViewCell) -> Void
  private let sections: [ItemSection]

  required init(sections: [ItemSection]) {
    self.sections = sections

    super.init()
  }

  subscript(indexPath: IndexPath) -> ItemSection.Item {
    return self.sections[indexPath.section].rows[indexPath.row]
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.sections.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.sections[section].rows.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = self[indexPath]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier, for: indexPath) as? CollectionViewCell else {
      fatalError("Expecting to dequeue a `CollectionViewCell` from the collectionView")
    }

    return cell
  }
}
