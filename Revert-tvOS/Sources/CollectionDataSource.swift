//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionDataSource<Object: Collectable, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (HomeCollectionCell, item: HomeItem) -> Void
  
  required init(collection: CollectableCollection<HomeItem>, configureCell: CellConfigurator, cellIdentifier: String) {
    self.collection = collection
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier
    
    super.init()
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return self.collection.countOfItems
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as? HomeCollectionCell else {
      fatalError("Expecting to dequeue a `CollectionViewCell` from the collectionView")
    }
    
    let item = self.collection[indexPath]
    self.configureCell(cell, item: item)
    return cell
  }
  
  // MARK: Private
  private let collection: CollectableCollection<HomeItem>
  private let configureCell: CellConfigurator
  private let cellIdentifier: String
}
