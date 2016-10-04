//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionDataSource<Object: Collectable, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (HomeCollectionCell, _ item: HomeItem) -> Void
  typealias ItemFilterClosure = (HomeItem) -> Bool
  typealias GroupFilterClosure = (CollectableGroup<HomeItem>) -> Bool

  required init(collection: CollectableCollection<HomeItem>, configureCell: @escaping CellConfigurator, cellIdentifier: String) {
    self.unfilteredCollection = collection
    self.collection = collection
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier

    super.init()
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.collection.countOfItems
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? HomeCollectionCell else {
      fatalError("Expecting to dequeue a `CollectionViewCell` from the collectionView")
    }

    let item = self.collection[indexPath]
    self.configureCell(cell, item)
    return cell
  }

  subscript(indexPath: IndexPath) -> HomeItem {
    return self.collection[indexPath]
  }

  func clearFilter() {
    self.collection = self.unfilteredCollection
  }

  func filter(_ filterClosure: ItemFilterClosure) {
    self.collection = self.unfilteredCollection.filteredCollectableCollection(filterClosure)
  }

  func filterGroups(_ filterClosure: GroupFilterClosure) {
    self.collection = self.unfilteredCollection.groupFilteredCollectableCollection(filterClosure)
  }

  // MARK: Private
  fileprivate let unfilteredCollection: CollectableCollection<HomeItem>
  fileprivate var collection: CollectableCollection<HomeItem>
  fileprivate let configureCell: CellConfigurator
  fileprivate let cellIdentifier: String
}
