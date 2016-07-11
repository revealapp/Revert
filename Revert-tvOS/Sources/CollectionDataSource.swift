//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionDataSource<Object: Collectable, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
	typealias CellConfigurator = (HomeCollectionCell, item: HomeItem) -> Void
	typealias ItemFilterClosure = (HomeItem) -> Bool
	typealias GroupFilterClosure = (CollectableGroup<HomeItem>) -> Bool

	required init(collection: CollectableCollection<HomeItem>, configureCell: CellConfigurator, cellIdentifier: String) {
		self.unfilteredCollection = collection
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

	subscript(indexPath: NSIndexPath) -> HomeItem {
		return self.collection[indexPath]
	}

	func clearFilter() {
		self.collection = self.unfilteredCollection
	}

	func filter(filterClosure: ItemFilterClosure) {
		self.collection = self.unfilteredCollection.filteredCollectableCollection(filterClosure)
	}

	func filterGroups(filterClosure: GroupFilterClosure) {
		self.collection = self.unfilteredCollection.groupFilteredCollectableCollection(filterClosure)
	}

	// MARK: Private
	private let unfilteredCollection: CollectableCollection<HomeItem>
	private var collection: CollectableCollection<HomeItem>
	private let configureCell: CellConfigurator
	private let cellIdentifier: String
}
